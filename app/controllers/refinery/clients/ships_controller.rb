module Refinery
  module Clients
    class ShipsController < ::ApplicationController #< ::ActionController::Base
      #include ::Refinery::ApplicationController
      #helper ApplicationHelper
      #helper Refinery::Core::Engine.helpers
      #include Refinery::Admin::BaseController
      layout 'refinery/clients/layouts/login'


    	before_filter :client?, except: :new
    	before_filter :add_new_client?, only: :new

      crudify	:'refinery/ships/ship',
      			:xhr_paging => true

      before_filter	:all_collections, :only=>[:new, :edit, :create, :update]
      before_filter	:new_attach_init, :only=>[:new]
      before_filter	:edit_attach_init, :only=>[:edit, :update]
      before_filter	:create_attach_init, :only=>[:create]
      # before_filter	:attach_update, :only=>[:create, :update]

      def new
        @ship = Refinery::Ships::Ship.new(:client_id=>current_client.id)
      end

      def create
      	@attach = Refinery::Ships::Attachment.where({client_id: current_client.id, ship_id: nil}).first
		if (@ship = Refinery::Ships::Ship.create(params[:ship]){|s| s.client_id = current_client.id}).valid?  #do |s| s.client_id = current_client.id end).valid?
			flash.notice = t(
			'refinery.crudify.created',
			:what => "#{@ship.title}'"
			)

                    attach_update
                    ::Refinery::Inquiries::InquiryMailer.order_notification(@ship).deliver
			redirect_to office_path
		else
			create_or_update_unsuccessful 'new'
		end
      end

      # def edit
      #   # object gets found by find_#{singular_name} function
      #   @attach = Refinery::Ships::Attachment.where(ship_id: @ship.id).first
      # end

      def update
	      if @ship.update_attributes(params[:ship])
			#attach_update
			redirect_to office_path
		else
			create_or_update_unsuccessful 'edit'
	      end
      end

      def destroy
		if @ship.destroy
			redirect_to office_path
		end
      end
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
      def add_new_client?
      		redirect_to new_client_registration_path if !client_signed_in?
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
        @speeds = Refinery::Ships::Speedname.all
        @fuelnames = Refinery::Ships::Fuelname.all
        @vats = Refinery::Ships::Vat.all
      end

      def new_attach_init
	      	if @attach = Refinery::Ships::Attachment.where({client_id: current_client.id, ship_id: nil}).first
	      		@attach.photos.each {|e| e.destroy} if @attach.photos.any? 
	      		@attach.docs.each {|e| e.destroy} if @attach.docs.any?
	      		@attach.reload
	      	else
	      		@attach = Refinery::Ships::Attachment.create(client_id: current_client.id)
	      	end
	      	@fileholder = Refinery::Ships::Doc.new
      		@photoholder = Refinery::Ships::Photo.new
      end
      
      def edit_attach_init
    		@attach = Refinery::Ships::Attachment.where(ship_id: @ship.id).first
    		#@attach = Refinery::Ships::Attachment.where({client_id: current_client.id, ship_id: params[:id]}).first
    		@fileholder = Refinery::Ships::Doc.new
    		@photoholder = Refinery::Ships::Photo.new
    	end

    	def create_attach_init
    		@attach = Refinery::Ships::Attachment.where({client_id: current_client.id, ship_id: nil}).first
    		@fileholder = Refinery::Ships::Doc.new
    		@photoholder = Refinery::Ships::Photo.new
    	end

      def attach_update
    		@attach.update_attributes(ship_id: @ship.id)
      end
    end
  end
end
