module Refinery
  module Clients
    class RegistrationsController < Devise::RegistrationsController
    	layout 'refinery/clients/layouts/login'

    	protected
    	def after_sign_in_path_for(resource_or_scope)
    		refinery.root_path	
    	end
    	# def after_sign_out_path_for(resource_or_scope)
    	# 	refinery.root_path
    	# end

    end
  end
end