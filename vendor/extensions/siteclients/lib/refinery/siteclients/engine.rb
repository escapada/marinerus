module Refinery
  module Siteclients
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Siteclients

      engine_name :refinery_siteclients

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "siteclients"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.siteclients_admin_siteclients_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/siteclients/siteclient',
            :title => 'email'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Siteclients)
      end
    end
  end
end
