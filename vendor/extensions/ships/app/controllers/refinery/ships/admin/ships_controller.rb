module Refinery
  module Ships
    module Admin
      class ShipsController < ::Refinery::AdminController

      		# x = params[:id]
	      crudify	:'refinery/ships/ship', 
	      		:xhr_paging => true,
	      		:title_attribute => "title"
	      		#:include => [:carmodelsubtype, :carmodels]#,
			#:conditions => {:carmodels => {:id => proc{@model}.call}}#{:carmodels => {:id => 2}}#, :carmodelsubtype_id => params[:filter_type]}#,
			#:search_conditions => {:carmodels => {:id => proc{@model}.call}}#{:carmodels => {:id => 2}}#, :carmodelsubtype_id => params[:filter_type]}#,
			#:conditions => {:carmodels => {:id => lambda {return set_filter}.call}}#{:carmodels => {:id => 2}}#, :carmodelsubtype_id => params[:filter_type]}#,
			# :conditions => {:id => lambda {return 2}.call}


	      before_filter :all_collections, :only=>[:new, :edit]
	      before_filter	:new_attach_init, :only=>[:new]
	      before_filter	:edit_attach_init, :only=>[:edit, :update]
	      before_filter	:create_attach_init, :only=>[:create]
	      # before_filter	:get_param#, :only=>[:show]

	      # after_update	:send_notification, :only=>[:update]

	      def create
	            # if (@ship = Refinery::Ships::Ship.create(params[:ship]){|s| s.client_id = current_client.id}).valid?
	            if (@ship = Refinery::Ships::Ship.create(params[:ship])).valid?
	              flash.notice = t(
	                'refinery.crudify.created',
	                :what => "#{@ship.title}"
	              )

	              attach_update
	              create_or_update_successful
	            else
	              create_or_update_unsuccessful 'new'
	            end
	      	end

	      protected
	      def all_collections
	      	@categories = Refinery::Categories::Category.all
	      	@clients = Refinery::Clients::Client.all

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
	      	@speeds = Speedname.all
	      	@fuelnames = Fuelname.all
	      	@vats = Vat.all
	      end

	      def new_attach_init
		      	if @attach = Refinery::Ships::Attachment.where({client_id: nil, ship_id: nil}).first
		      		@attach.photos.each {|e| e.destroy} if @attach.photos.any? 
		      		@attach.docs.each {|e| e.destroy} if @attach.docs.any?
		      		@attach.reload
		      	else
		      		@attach = Refinery::Ships::Attachment.create(client_id: nil)
		      	end
		      	@fileholder = Refinery::Ships::Doc.new
	      		@photoholder = Refinery::Ships::Photo.new
	      end
	      
	      def edit_attach_init
	      		@attach = Refinery::Ships::Attachment.where(ship_id: @ship.id).first
	      		#@attach = Refinery::Ships::Attachment.where({client_id: nil, ship_id: params[:id]}).first
	      		@fileholder = Refinery::Ships::Doc.new
	      		@photoholder = Refinery::Ships::Photo.new
	      	end

	      	def create_attach_init
	      		@attach = Refinery::Ships::Attachment.where({client_id: nil, ship_id: nil}).first
	      		@fileholder = Refinery::Ships::Doc.new
	      		@photoholder = Refinery::Ships::Photo.new
	      	end

	      def attach_update
	      		@attach.update_attributes(ship_id: @ship.id)
	      end

	      def find_all_ships
	      		if params[:filter].present?
	      			session[:admin_filter] = {"date" => Time.now, "filter" => params[:filter]}
	      			# logger.debug("Time NOW minus 1 minute: #{Time.now-30.minutes}")
	      			session[:admin_filter]["filter"].to_i == 0 ? conditions = '' : conditions = "page_status_id = #{session[:admin_filter]["filter"]}"
	      			@filter_case = params[:filter]
	      		else
	      			if (session[:admin_filter].present? and (Time.now-session[:admin_filter]["date"] < 30.minutes))
	      				session[:admin_filter]["date"] = Time.now
	      				session[:admin_filter]["filter"].to_i == 0 ? conditions = '' : conditions = "page_status_id = #{session[:admin_filter]["filter"]}"
	      				# logger.debug("SESSION:    #{session[:admin_filter]}")
	      				@filter_case = session[:admin_filter]["filter"]
	      			else
	      				session[:admin_filter] = nil
	      				conditions = ''
	      				# logger.debug("SESSION:    #{session[:admin_filter]}")
	      				@filter_case = 0
	      			end
	      		end

					@ships = Ship.where(conditions)
				end

				def send_ship_to_subscribers(ship)
					# http_line = 
					#return http_line
				end

	      ######Send mail
	      # def send_notification
	      # 	logger.debug(@ship.page_status_id_changed?)
	      # 		::Refinery::Inquiries::InquiryMailer.published_notification(@ship).deliver if (@ship.page_status_id_changed? and @ship.page_status_id == 2)
	      # end

      end
    end
  end
end
