after_bundle do
  git :init unless no?('Initialize Git Repo? [yes]')

  unless no?('Add and Commit files? [yes]')
    git add: '.'

    commit_message = ask("Commit Message? [Initial commit of generated app]")
    commit_message = 'Initial commit of generated app' if commit_message.blank?
    git commit: "-a -m '#{commit_message}'"
  end
end