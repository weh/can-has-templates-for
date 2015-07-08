gem 'mysql2'

puts '--> removing sqlite stuff'
gsub_file 'Gemfile', "gem 'sqlite3'\n", ''
template "config/databases/mysql.yml", "config/database.yml"

puts '--> copy config files as template'
run 'cp config/database.yml config/database.yml.template'
run 'cp config/secrets.yml config/secrets.yml.template'

# Set The Database credentials after copying the database.yml!
puts '--> setting database credentials'
db_user = ask('database user? [root]') || 'root'
db_pass = ask('database pass? []') || ''
gsub_file 'config/database.yml', '  username: root', "  username: #{db_user}"
gsub_file 'config/database.yml', '  password:', "  password: #{db_pass}"

after_bundle do
  rake 'db:create' unless no?('Create Database? [yes]')
end