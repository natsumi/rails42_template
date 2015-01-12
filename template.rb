require 'pry'

gem 'slim-rails'
gem 'chronic'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
end

gem_group :development do
  gem 'spirit_fingers'
  gem 'coffee-rails-source-maps'
  gem 'better_errors'
  gem 'meta_request'
  gem 'pry-toys'
  gem 'bullet'
  gem 'guard-livereload'
  gem 'terminal-notifier-guard'
end

# remove old css
remove_file 'app/assets/stylesheets/application.css'
#
# generate 'app/assets/stylesheets/application.scss'
file 'app/assets/stylesheets/application.scss', <<-CODE
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, vendor/assets/stylesheets,
 * or vendor/assets/stylesheets of plugins, if any, can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the top of the
 * compiled file, but it's generally better to create a new file per style scope.
 *
 *= require_tree .
 *= require_self
 */
CODE

# generate 'app/assets/stylesheets/application.scss'
file 'app/assets/stoylesheets/framework_and_overrides.css.scss', <<-CODE
// "bootstrap-sprockets" must be imported before "bootstrap" and "bootstrap/variables"
@import "bootstrap-sprockets";
@import 'bootstrap';
@import 'bootstrap/theme';
CODE

route "root to: 'static_pages#index'"
generate :controller, 'StaticPages index --no-test-framework --no-assets --no-helper'


after_bundle do
  # create guardfile
  run 'guard init rspec'
  run 'guard init livereload'

  # inital git commit
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
