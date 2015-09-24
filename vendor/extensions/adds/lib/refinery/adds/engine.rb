module Refinery
  module Adds
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Adds

      engine_name :refinery_adds

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "adds"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.adds_admin_adds_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/adds/add'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Adds)
      end
    end
  end
end
