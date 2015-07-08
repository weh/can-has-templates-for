gem_group :development do
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-maintenance', require: false
end

after_bundle do
  puts '--> enabling capistrano'
  run 'bundle exec cap install'

  puts '--> enabling capistrano-rvm'
  gsub_file 'Capfile', "# require 'capistrano/rvm'", "require 'capistrano/rvm'"
  
  puts '--> enabling capistrano-rails'
  gsub_file 'Capfile', "# require 'capistrano/bundler'", "require 'capistrano/bundler'"
  gsub_file 'Capfile', "# require 'capistrano/rails/assets'", "require 'capistrano/rails'"
  

  gsub_file 'config/deploy.rb', '# set :linked_', 'set :linked_'

  puts '--> enabling capistrano-maintenance'
  gsub_file 'Capfile', "# require 'capistrano/rails/migrations'", "require 'capistrano/maintenance'"

  puts '--> removing comments from Capfile'
  gsub_file 'Capfile', /#.*\n/, ''

end