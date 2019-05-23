require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MakeupByYuna
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    FACEBOOK_APP_ID: "358385804815972"
	FACEBOOK_APP_SECRET: "95e0798e0becaf94a79638d66466c263"
  end
end

