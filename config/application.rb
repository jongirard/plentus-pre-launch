require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module PlentusPreLaunch
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.enforce_available_locales = true
    config.autoload_paths += %W(#{config.root}/lib)
    config.after_initialize do |app|
          app.routes.append{match '*path', :to => 'application#routing_error', via: :get}
        end
    config.time_zone = 'Pacific Time (US & Canada)'
    config.generators do |g| 
      g.test_framework :rspec, 
      :fixtures => true, 
      :view_specs => false, 
      :helper_specs => false, 
      :routing_specs => false, 
      :controller_specs => true, 
      :request_specs => true 
      g.fixture_replacement :factory_girl, :dir => "spec/factories" 
      end
      config.to_prepare do
      Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "authorized_account" : "application" }
      Devise::SessionsController.layout "nav_disabled"
      Devise::PasswordsController.layout "nav_disabled"
      Devise::ConfirmationsController.layout "nav_disabled"
    end
    config.assets.precompile += ['authorized/*']
  end
end
