module Refinery
  module Clients
    class SessionsController < Devise::SessionsController
    	layout 'refinery/clients/layouts/login'
    	#before_filter :check, :only=>[:create]

	def create
     		client = Client.find_by_email(params[:client][:email])
		if client.present? and client.valid_password?(params[:client][:password])
			self.resource = client
		else
			self.resource = warden.authenticate!(auth_options)
		end
		set_flash_message(:notice, :signed_in) if is_navigational_format?
		sign_in(resource_name, resource)
		respond_with resource, :location => after_sign_in_path_for(resource)
	end

      def create_default
        self.resource = warden.authenticate!(auth_options)
        set_flash_message(:notice, :signed_in) if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_in_path_for(resource)
      end

    	protected
    	def after_sign_in_path_for(resource_or_scope)
    		refinery.root_path
    	end
    	# def after_sign_out_path_for(resource_or_scope)
    	# 	refinery.root_path
    	# end

    # 	def auth_options
    #   { :default_scope => :client, :default_strategies => :client}
    # end

    def check
    	#request.env["devise.skip_timeout"] = true 
    	request.env["authentication_keys"] = [:email]

    	logger.debug("//////////////////////////////////////////////////////////")
    	logger.debug(">request.env:  #{lambda{request.env.each do |t| return t end}.call}")
    	logger.debug("//////////////////////////////////////////////////////////")
    	logger.debug(">>>>>>>>>>>>>>>>>>devise.skip_timeout:   #{request.env["devise.skip_timeout"]} >>class: devise.skip_timeout:   #{request.env.class}")
    	logger.debug(">>>>>>>>>>>>>>>>>>warden:   #{warden}>>class:   #{warden.class}")
    	logger.debug(">>>>>>>>>>>>>>>>>>warden:   #{request.env["authentication_keys"]}")
    	logger.debug(">>>>>>>>>>>>>>>>>>warden:   #{request.env["request_keys"]}")

    end
    	
    end
  end
end