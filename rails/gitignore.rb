puts '--> replace .gitignore'
run 'wget https://raw.githubusercontent.com/github/gitignore/master/Rails.gitignore -O .gitignore'

insert_into_file '.gitignore', "config/database.yml\n", :after => "config/secrets.yml\n"