Marinerus::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # ActionMailer setup (MY)
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.sendmail_settings = { :location => '/usr/sbin/sendmail', :arguments => '-i -t'}
  

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  # default_options method works since Rails4 only. for Rails3 works ActionMailer::Base.default :from => 'no-reply@ru.ru'
  # config.action_mailer.default_options = {from: 'no-reply@ru.ru'}

  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #   address:              'smtp.gmail.com',
  #   port:                 587,
  #   domain:               'example.com',
  #   user_name:            'escapada83@gmail.com',
  #   password:             'Nobody9j',
  #   authentication:       'plain',
  #   enable_starttls_auto: true  }

  # ActionMailer setup (DEFAULT)
  ## Don't care if the mailer can't send
  # if config.respond_to?(:action_mailer)
  #   config.action_mailer.raise_delivery_errors = false
  # end

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  # Paperclip setings
  Paperclip.options[:command_path] = "/usr/bin/"

end

ActionMailer::Base.default :from => 'no-reply@marinerus.ru'