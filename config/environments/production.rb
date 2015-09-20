Marinerus::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true


  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  config.assets.precompile += %w( admin_style.css )
  config.assets.precompile += %w( admin_uploadfiles.js )
  config.assets.precompile += %w( admin_plus.js )

  # i gues ....
  #config.assets.precompile += %w( jquery-fileupload/basic.js )
  # if not than:
  config.assets.precompile += %w( jquery.ui.widget.js )
  config.assets.precompile += %w( jquery.iframe-transport.js )
  config.assets.precompile += %w( jquery.fileupload.js )

  config.action_mailer.default_url_options = { host: 'site.marinerus.lclients.ru' }
  # config.action_mailer.delivery_method = :sendmail

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp-20.1gb.ru',
    port:                 465,
    domain:               'site.marinerus.lclients.ru',
    user_name:            'u113709',
    password:             '858d9666',
    authentication:       'login',
    enable_starttls_auto: true  }

  # Disable delivery errors, bad email addresses will be ignored
  # if config.respond_to?(:action_mailer)
    # config.action_mailer.raise_delivery_errors = false
  # end

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Paperclip setings
  Paperclip.options[:command_path] = "/usr/bin/"
  
end

ActionMailer::Base.default :from => 'no-reply@marinerus.ru'
