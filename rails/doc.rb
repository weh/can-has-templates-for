puts '--> replace README'
run 'rm README.rdoc'
create_file 'README.md', "# #{app_name}"

puts '--> add CHANGELOG'
# output one-liners for installed stuff
create_file 'CHANGELOG.md', "## #{app_name} 0.1 (#{Date.new.strftime})"
