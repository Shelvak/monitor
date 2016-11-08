# Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
# Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
# TODO: check why setting this here does not work
# Rails.application.config.time_zone = 'Buenos Aires'

# The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
# Rails.config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
Rails.application.config.i18n.default_locale = :es
