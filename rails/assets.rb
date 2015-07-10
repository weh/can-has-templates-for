setup_javascript
setup_stylesheets
add_asset_caching_htacces


def setup_javascript
  empty_directory_with_keep_file 'app/assets/javascripts/shared'
  gsub_file 'app/assets/javascripts/application.js', '//= require_tree .', '//= require_directory ./shared'
  run 'cp app/assets/javascripts/application.js app/assets/javascripts/backend.js'

  empty_directory_with_keep_file 'app/assets/javascripts/frontend'
  insert_into_file 'app/assets/javascripts/application.js', "//= require_directory ./frontend\n", :after => "//= require_directory ./shared\n"

  empty_directory_with_keep_file 'app/assets/javascripts/backend'
  insert_into_file 'app/assets/javascripts/backend.js', "//= require_directory ./backend\n", :after => "//= require_directory ./shared\n"
end

def setup_stylesheets
  run 'cp app/assets/stylesheets/application.css app/assets/stylesheets/backend.css'

  empty_directory 'app/assets/stylesheets/frontend'
  empty_directory_with_keep_file 'app/assets/stylesheets/frontend/partials'
  create_file 'app/assets/stylesheets/frontend/config.css.sass', '//@import partials/xxx'

  gsub_file 'app/assets/stylesheets/application.css', ' *= require_self', ' *= require_directory ./frontend'
  gsub_file 'app/assets/stylesheets/application.css', ' *= require_tree .', ' *= require_self'

  empty_directory 'app/assets/stylesheets/backend'
  empty_directory_with_keep_file 'app/assets/stylesheets/backend/partials'
  create_file 'app/assets/stylesheets/backend/config.css.sass', '//@import partials/xxx'

  gsub_file 'app/assets/stylesheets/backend.css', ' *= require_self', ' *= require_directory ./backend'
  gsub_file 'app/assets/stylesheets/backend.css', ' *= require_tree .', ' *= require_self'
end

def add_asset_caching_htacces
  empty_directory 'public/assets'
  create_file 'public/assets/.htaccess', <<HTACCESS
# Use of ETag is discouraged when Last-Modified is present
Header unset ETag
FileETag None
# RFC says only cache for 1 year
ExpiresActive On
ExpiresDefault "access plus 1 year"
HTACCESS
end