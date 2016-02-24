module Refinery
  module Ships
    module Admin
      class ShipsController < ::Refinery::AdminController
      	layout 'subscribing', :only=>[:send_ship_to_subscribers]

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
	      before_filter	:update_mailing_list, :only=>[:send_ship_to_subscribers]

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

	      def send_ship_to_subscribers
			@ship = Ship.where(id:params[:ship_id]).first
			# logger.debug(@ship.to_hash)

			data = Multimap.new
			data[:from] = "marinerus <no-reply@marinerus.ru>"
			data[:to] = "escapada83@yandex.ru"
			data[:subject] = "New object published / Опубликован новый лот"
			# data[:text] = "Testing some shit!"
			data[:html] = render_to_string :shipmailing # "<html><body><img src='http://marinerus.ru/assets/logo.png' /></body></html>"
			#data[:attachment] = File.new(File.join("files", "test.jpg"))
			#data[:attachment] = File.new(File.join("files", "test.txt"))
			
			#RestClient.post "https://api:key-2b931b07a70d72df02e817bc79e9a8ba"\
			#"@api.mailgun.net/v3/mailgun.marinerus.ru/messages",
			# response = RestClient.post "https://api:key-2b931b07a70d72df02e817bc79e9a8ba"\
			# "@api.mailgun.net/v3/sandboxf89ae43af0ff48269a2e3fc064e4f85d.mailgun.org/messages",
			# data.to_hash
			# logger.debug(render_to_string :shipmailing)
			# # logger.debug(data.to_hash)
			# respond_to do |format|
			# 	format.js {
			# 		response.code == 200 ? flash.now[:notice] = "Письмо тправлено!" : flash.now[:notice] = "Не удалось отправить. Попробуйте позже."
			# 	}
			# end
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

		def update_mailing_list
			clients = Refinery::Clients::Client.all
			#Hash[clients.map {|subscriber| ["adress"subscriber.adress]}]
			json = clients.map {|c| [["adress", c.email], ["subscribed", c.mail_me]]}

			RestClient.post("https://api:key-2b931b07a70d72df02e817bc79e9a8ba" \
                  "@api.mailgun.net/v3/lists/subscribers@sandboxf89ae43af0ff48269a2e3fc064e4f85d.mailgun.org/members.json",
                  :upsert => true,
                  :members => '[{"adress" => "number1@ya.ru"}]')


				# subscribers[:adress] << client.email
				# client.mail_me ? subscribers[:] 
		end

      end
    end
  end
end
