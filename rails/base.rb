gem 'mysql2'
gem 'haml-rails'
gem 'simple_form'
gem 'kaminari' if yes?('Kaminari? [no]') 
gem 'nokogiri' if yes?('Nokogiri? [no]')
gem 'prawn' if yes?('Prawn? [no]') 

fabication = yes?('Fabrication? [no]')

gem_group :development, :test do
  gem 'pry'
  gem 'rspec-rails'
  gem 'capybara'
  if fabication
    gem 'fabrication'
    gem 'faker' if yes?('Faker? [no]') 
  end
end

puts '--> removing sqlite stuff'
gsub_file 'Gemfile', "gem 'sqlite3'\n", ''
template "config/databases/mysql.yml", "config/database.yml"

puts '--> copy config files as template'
copy_file 'config/database.yml', 'config/database.yml.template'
copy_file 'config/secrets.yml', 'config/secrets.yml.template'

after_bundle do
  puts '--> stopping spring https://github.com/rspec/rspec-rails/issues/996'
  run 'spring stop'

  puts '--> converting layout to haml'
  generate 'haml:application_layout', 'convert'
  run 'rm app/views/layouts/application.html.erb'

  puts '--> enabling simple form'
  generate 'simple_form:install'

  puts '--> enabling rspec-rails'
  generate 'rspec:install'

  puts '--> enabling capybara'
  inject_into_file 'spec/rails_helper.rb', "require 'capybara/rails'\nrequire 'capybara/rspec'\n", after: "require 'rspec/rails'\n"

  puts '--> removing generated test folder'
  run 'rm -rf ./test'

  puts '--> creating spec subfolders'
  inside 'spec' do
    empty_directory_with_keep_file 'features'
    empty_directory_with_keep_file 'controllers'
    empty_directory_with_keep_file 'models'

    if fabication
      empty_directory_with_keep_file 'fabricators'
    end 
  end
end