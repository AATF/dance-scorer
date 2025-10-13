# frozen_string_literal: true

RailsLiveReload.configure do |config|
  config.url = "/rails/live/reload"

  config.watch %r{app/views/.+\.(erb|haml|slim)$}, reload: :always
  config.watch %r{(app|vendor)/(assets|javascript)/\w+/(.+\.(css|js|html|png|jpg|ts|jsx)).*}, reload: :always
  config.watch %r{app/controllers/.+\.rb}, reload: :always
  # config.watch %r{config/locales/.+\.yml}, reload: :always

  # Ignored folders & files
  # config.ignore %r{node_modules/}

  config.enabled = Rails.env.development?
end if defined?(RailsLiveReload)
