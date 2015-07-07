module Refinery
  module Clients
      class ShipsController < ::ApplicationController
      	before_filter :client?

	      crudify	:'refinery/ships/ship', 
	      		:xhr_paging => true

	      before_filter :all_collections, :only=>[:new, :edit]

	      protected
	      def client?
	      	redirect_to root_path if !client_signed_in?
	      end
	      def all_collections
	      	@categories = Refinery::Categories::Category.all
	      	#@clients

	      	@page_statuss = Refinery::Ships::PageStatus.all
	      	@statuss = Refinery::Ships::Status.all
	      	@areas = Refinery::Ships::Area.all
	      	@choices = Refinery::Ships::Choice.all
	      	@conditions = Refinery::Ships::Condition.all
	      	@currencies = Refinery::Ships::Currency.all
	      	@enginetypes = Refinery::Ships::Enginetype.all
	      	@fuels = Refinery::Ships::Fuel.all
	      	@gmdsss = Refinery::Ships::Gmdss.all
	      	@hullmaterials = Refinery::Ships::Hullmaterial.all
	      	@hulltypes = Refinery::Ships::Hulltype.all
	      	@powers = Refinery::Ships::Power.all
	      	@propulsions = Refinery::Ships::Propulsion.all
	      	@registrations = Refinery::Ships::Registration.all
	      	@registrs = Refinery::Ships::Registr.all
	      	@speeds = Refinery::Ships::Speed.all
	      	@vats = Refinery::Ships::Vat.all
	      end
      end
  end
end
