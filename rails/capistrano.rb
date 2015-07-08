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

  unless no?('Add German maintenance Template? [yes]')
    german_maintenance
  end

  puts '--> removing comments from Capfile'
  gsub_file 'Capfile', /#.*\n/, ''
end

def german_maintenance
  german_template = <<GERMAN_MAINTENANCE
!!!
%html
  %head
    %meta{:content => "text/html; charset=UTF-8", "http-equiv" => "Content-Type"}/
    %title Unterhaltsarbeiten
    %style
      body { width: 400px; margin: 100px auto; font: 300 120% "OpenSans", "Helvetica Neue", "Helvetica", Arial, Verdana, sans-serif; }
      h1 { font-weight: 300; }
  %body
    %h1 Unterhaltsarbeiten
    %p= "Aufgrund von \#{ reason ? reason : 'Unterhaltsarbeiten' } ist das System zur Zeit nicht erreichbar (\#{ Time.now.strftime('%d.%m.%Y - %H:%M') })."
    %p= "Das System wird \#{ deadline ? deadline : 'so bald als m&ouml;glich' } wieder verf&uuml;gbar sein."
GERMAN_MAINTENANCE

  create_file 'app/views/shared/maintenance.html.haml', german_template
  insert_into_file 'config/deploy.rb', "\nset :maintenance_template_path, 'app/views/shared/maintenance.html.haml'\n", :after => "# set :keep_releases, 5\n"
end