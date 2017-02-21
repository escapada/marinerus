require 'raptcha'

module Refinery
  module Clients
    class RegistrationsController < Devise::RegistrationsController
      prepend_before_filter :authenticate_scope!, :only => [:edit_password, :edit, :update, :destroy]
# 
#      prepend_before_filter :captcha, :only => [ :create ]
      prepend_before_filter :recaptcha, :only => [ :create ]
# 
      after_filter :subscribed, :only => [:create, :update]
      after_filter :delete_subscriber, :only => [:destroy]
      helper Refinery::Core::Engine.helpers
      layout 'refinery/clients/layouts/login'

      # Only password change
      def edit_password
        render :edit_password
      end

      def destroy
        resource.destroy
        Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
        set_flash_message :notice, :destroyed if is_navigational_format?
        # respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
        redirect_to after_sign_out_path_for(resource_name)
      end

      def raptcha_generate
        Raptcha.render(controller=self, params)
      end

      protected
      def after_sign_in_path_for(resource_or_scope)
        refinery.root_path	
      end
      def after_update_path_for(resource)
        office_path
      end
      def subscribed
          response = RestClient.post("https://api:key-2b931b07a70d72df02e817bc79e9a8ba" \
          "@api.mailgun.net/v3/lists/subscribers@mailgun.marinerus.ru/members",
          :upsert => true,
          :address => resource.email,
          :subscribed => resource.mail_me)
      end

      def delete_subscriber
        RestClient.delete("https://api:key-2b931b07a70d72df02e817bc79e9a8ba" \
        "@api.mailgun.net/v3/lists/subscribers@mailgun.marinerus.ru/members" \
        "/#{resource.email}")
      end
      # def after_sign_out_path_for(resource_or_scope)
      # 	refinery.root_path
      # end

      # def captcha
      #   # redirect_to 'http://google.ru', flash: { someshit: "Get out! Motherfucker!" } if !(Raptcha.valid?(params))
      #   redirect_to root_url, flash: { someshit: "Get out! Motherfucker!" } if !(Raptcha.valid?(params))
      # end

      def recaptcha
        build_resource

        render 'new' if !verify_recaptcha(model: resource)
      end

    end
  end
end