BASE_PATH = 'https://github.com/weh/can-has-templates-for/'

puts <<INFO

------------------===<<{ WARNING }>>===------------------
Make Sure RVM Setup is correct: rvm use 2.2.0@blog_gemset

INFO

unless no?('Ready? [yes]')

  unless no?('Base Stuff (haml, simple form. rspec, capybara)? [yes]')
    apply "#{BASE_PATH}/rails/base.rb"
    apply "#{BASE_PATH}/rails/gitignore.rb"
  end

  # bootstrap
  apply "#{BASE_PATH}/rails/devise.rb" if yes?('Devise? [no]')
  apply "#{BASE_PATH}/rails/capistrano.rb" unless no?('Capistrano? [yes]')

  # Reorganize Gemfile Structure
  run "gem install bundler-reorganizer"
  run "bundler-reorganizer Gemfile"

  apply "#{BASE_PATH}/rails/doc.rb" unless no?('README and CHANGELOG? [yes]')
  apply "#{BASE_PATH}/rails/git.rb"
end