module Refinery
  module Clients
    class PasswordsController < Devise::PasswordsController
    	layout 'refinery/clients/layouts/login'
    	# prepend_before_filter :log, :only => :update

    	  def edit
	    self.resource = resource_class.new
	    resource.reset_password_token = params[:reset_password_token]
	  end

	  # PUT /resource/password
	  def update
	    self.resource = resource_class.reset_password_by_token(resource_params)

	    if resource.errors.empty?
	      resource.unlock_access! if unlockable?(resource)
	      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
	      set_flash_message(:notice, flash_message) if is_navigational_format?
	      sign_in(resource_name, resource)
	      respond_with resource, :location => after_resetting_password_path_for(resource)
	    else
	      respond_with resource
	    end
	  end


	  protected
		def after_sending_reset_password_instructions_path_for(resource_name)
			office_path
		end
		def after_resetting_password_path_for(resource)
			office_path
		end
    end
  end
end