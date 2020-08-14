![Weh can has Template?](https://raw.githubusercontent.com/weh/can-has-templates-for/master/canhastemplates.jpg "Weh can has Template?")


## What is this?
This is a Rails Application Template, that can be used when creating a new Rail Application.
You can generate a new Rail Application using this template

```console
rails new blog -m  https://raw.githubusercontent.com/weh/can-has-templates-for/master/rails.rb
```

to apply the Template on an existing Application you can use the Rake Task

```console
bin/rake rails:template LOCATION=https://raw.githubusercontent.com/weh/can-has-templates-for/master/rails.rb
```

Using the Rake Task, you can also choose a partial template to be applied.
E.g. if you only need to add the Devise part:

```console
bin/rake rails:template LOCATION=https://raw.githubusercontent.com/weh/can-has-templates-for/master/rails/devise.rb
```

Check [The Rails Guides](http://guides.rubyonrails.org/rails_application_templates.html) for more Information about Rails App Templates.

## What can and will be installed?

The Template will install Gems, generates and changes Config Files, and can commit the made Changes.
For Some Parts it will ask you if you want to install it. Others will be installed without Questions.

See The List below to find out what is Optional or Default.

## Why?
This can be a way to save Time, if you create Rails Applications and use the same Gems for multiple projects.
The selection of Gems is based on our own needs. Feel Free to use it, or fork it and create your own version.

### Default installations and Changes
The Following Changes will be made without any questions.

* mysql2 with config/database.yml
* haml-rails and replace layout .erb with .haml version
* simple_form
* replace .gitignore with [github version](https://github.com/github/gitignore/blob/master/Rails.gitignore)
* Reorganize Gemfile groups 

#### development and test
* pry
* rspec-rails
  * creating folders for features, controllers and models specs
* capybara

### Optional
* devise
* kaminari
* prawn
* README.md and CHANGELOG.md
* Git init with initial commit

#### development
* create and migrate database
* capystrano including
  * capistrano-rvm
  * capistrano-bundler
  * capistrano-rails
  * capistrano-maintenance
  * german maintenance template.
  * removing test folder

#### development and test
* fabrication
  * creating specs/fabricators folder
* faker
