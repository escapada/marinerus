module Refinery
  module Clients
    class ConfirmationsController < Devise::ConfirmationsController
      helper Refinery::Core::Engine.helpers
      # layout 'refinery/clients/layouts/login'
      # GET /resource/confirmation/new
      def new
        build_resource({})
      end

      # POST /resource/confirmation
      def create
        self.resource = resource_class.send_confirmation_instructions(resource_params)

        if successfully_sent?(resource)
          respond_with({}, :location => after_resending_confirmation_instructions_path_for(resource_name))
        else
          respond_with(resource)
        end
      end

      # GET /resource/confirmation?confirmation_token=abcdef
      def show
        self.resource = resource_class.confirm_by_token(params[:confirmation_token])

        if resource.errors.empty?
          logger.debug(resource)
          logger.debug(resource_name)
          set_flash_message(:notice, :confirmed) if is_navigational_format?
          # respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
          redirect_to office_path if sign_in(resource_name, resource)
          # all my stupied tries next:
          # respond_with_navigational(resource){ redirect_to office_path }
          # respond_with resource, :location => after_sign_in_path_for(resource)
        else
          respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render :new }
        end
      end

      protected

        # The path used after resending confirmation instructions.
        def after_resending_confirmation_instructions_path_for(resource_name)
          new_session_path(resource_name) if is_navigational_format?
        end

        # The path used after confirmation.
        def after_confirmation_path_for(resource_name, resource)
          after_sign_in_path_for(resource)
        end
      
    end
  end
end