gem 'devise'

after_bundle do
  generate 'devise:install'

  model_name = ask("What would you like the user model to be called? [user]")
  model_name = "user" if model_name.blank?
  generate 'devise', model_name
end
