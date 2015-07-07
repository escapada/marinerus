module Refinery
  module Ships
    module Admin
      class ShipsController < ::Refinery::AdminController

	      crudify	:'refinery/ships/ship', 
	      		:xhr_paging => true

	      before_filter :all_collections, :only=>[:new, :edit]

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
end
