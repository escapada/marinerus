module Refinery
  module Clients
    class ShipsController < ::ApplicationController #< ::ActionController::Base
      #include ::Refinery::ApplicationController
      #helper ApplicationHelper
      #helper Refinery::Core::Engine.helpers
      #include Refinery::Admin::BaseController


    	before_filter :client?

      crudify	:'refinery/ships/ship',
      				:xhr_paging => true

      before_filter	:all_collections, :only=>[:new, :edit]
      #before_filter	:attach_init, :only=>[:new]
      #after_filter	:attach_update, :only=>[:create]

      def new
        @ship = Refinery::Ships::Ship.new(:client_id=>current_client.id)
      end

      def create
        if (@ship = Refinery::Ships::Ship.create(params[:ship]){|s| s.client_id = current_client.id}).valid? #do |s| s.client_id = current_client.id end).valid?
          flash.notice = t(
            'refinery.crudify.created',
            :what => "'\#{@ship.title}'"
          )

          redirect_to office_path
        else
          create_or_update_unsuccessful 'new'
        end
      end

      # def edit
      #   # object gets found by find_#{singular_name} function
      #   @attach = Refinery::Ships::Attachment.where(ship_id: @ship.id).take
      # end

      def update
        if @ship.update_attributes(params[:ship])
          # flash.notice = t(
          #   'refinery.crudify.updated',
          #   :what => "'\#{@#{singular_name}.#{options[:title_attribute]}}'"
          # )

          redirect_to office_path
        else
          create_or_update_unsuccessful 'edit'
        end
      end

      # def destroy
      #   # # object gets found by find_#{singular_name} function
      #   # title = @#{singular_name}.#{options[:title_attribute]}
      #   # if @#{singular_name}.destroy
      #   #   flash.notice = t('destroyed', :scope => 'refinery.crudify', :what => "'\#{title}'")
      #   # end

      #   # redirect_to redirect_url
      # end
#####################################----Set locale----#############################################################################
      def find_or_set_locale
        if (params[:set_locale] and ::Refinery::I18n.locales.keys.map(&:to_sym).include?(params[:set_locale].to_sym))
          ::Refinery::I18n.current_locale = params[:set_locale].to_sym
          redirect_back_or_default(refinery.admin_root_path) and return
        else
          ::I18n.locale = ::Refinery::I18n.current_locale
        end
      end

      def globalize!
        if ::Refinery::I18n.frontend_locales.any?
          if params[:switch_locale]
            Thread.current[:globalize_locale] = params[:switch_locale].to_sym
          elsif ::I18n.locale != ::Refinery::I18n.default_frontend_locale
            Thread.current[:globalize_locale] = ::Refinery::I18n.default_frontend_locale
          end
        end

        Thread.current[:globalize_locale] = ::I18n.locale if Thread.current[:globalize_locale].nil?
      end
      # globalize! should be prepended first so that it runs after find_or_set_locale
      prepend_before_filter :globalize!, :find_or_set_locale
      protected :globalize!, :find_or_set_locale
###################################################################################################################################
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
      def attach_init
      	if @attach = Refinery::Ships::Attachment.where({client_id: current_client.id, ship_id: nil}).first
      		# @attach = Refinery::Ships::Attachment.where({client_id: current_client.id, ship_id: nil}).take
      		@attach.photos.destroy
      		@attach.files.destroy
      	else
      		@attach = Refinery::Ships::Attachment.create(client_id: current_client.id)
      	end      	
      end
      def attach_update
      	@attach.update_attributes(ship_id: @ship.id)
      end
    end
  end
end
