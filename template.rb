# add PWD to source paths
def source_paths
  [File.join(File.expand_path(File.dirname(__FILE__)), 'rails_root')] +
    Array(super)
end

gem 'slim-rails'
gem 'chronic'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'database_cleaner'
  gem "spring-commands-rspec"
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


after_bundle do

  # remove old css
  remove_file 'app/assets/stylesheets/application.css'

  route "root to: 'static_pages#index'"
  generate :controller, 'StaticPages index --no-test-framework --no-assets --no-helper'

  # create spec files
  # run 'rails generate rspec:install'
  generate 'rspec:install'

  # copy application stubs
  directory 'spec'
  directory 'app'

  # generate spring binstubs
  run 'spring binstub --all'

  # create guardfile
  run 'guard init rspec'
  run 'guard init livereload'

  # inital git commit
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
