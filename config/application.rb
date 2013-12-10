require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module GestionCe
	class Application < Rails::Application
		config.autoload_paths += %W(#{config.root}/lib)
		config.i18n.enforce_available_locales = true
		config.i18n.default_locale = :fr
	end
end
