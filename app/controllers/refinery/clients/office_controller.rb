module Refinery
  module Clients
    class OfficeController < ::ApplicationController
        layout 'refinery/clients/layouts/login'
        #before_filter :check, :only=>[:create]
        # crudify   :'refinery/ships/ship', 
            # :xhr_paging => true

        before_filter :all_collections, :only=>[:new, :edit]

        def index
            client_signed_in? ? @ships = Refinery::Ships::Ship.where(:client_id=>current_client.id) : redirect_to(root_path)
            #logger.debug("#{client.ships.any?}, #{current_client.class}")
        end
        

        protected
        def all_collections
        @categories = Refinery::Categories::Category.all
        #@clients

        @page_statuss = PageStatus.all
        @statuss = Status.all
        @areas = Area.all
        @choices = Choice.all
        @conditions = Condition.all
        @currencies = Currency.all
        @enginetypes = Enginetype.all
        @fuels = Fuel.all
        @gmdsss = Gmdss.all
        @hullmaterials = Hullmaterial.all
        @hulltypes = Hulltype.all
        @powers = Power.all
        @propulsions = Propulsion.all
        @registrations = Registration.all
        @registrs = Registr.all
        @speeds = Speed.all
        @vats = Vat.all
        end

    end
  end
end

# module Refinery
#   module Clients
#     class OfficeController < Devise::SessionsController
#         layout 'refinery/clients/layouts/login'
#         #before_filter :check, :only=>[:create]

#         def index
#             client = Client.find_by_email(params[:client][:email])
#         end
        
#     end
#   end
# end

