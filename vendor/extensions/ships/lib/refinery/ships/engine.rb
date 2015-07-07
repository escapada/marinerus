module Refinery
  module Ships
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Ships

      engine_name :refinery_ships

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "ships"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.ships_admin_ships_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/ships/ship'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Ships)
      end
    end
  end
end
