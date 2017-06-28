module Refinery
  module Siteclients
    module Admin
      class SiteclientsController < ::Refinery::AdminController
	      after_filter :delete_subscriber, :only => [:destroy]

        crudify :'refinery/siteclients/siteclient',
                :order => ('id ASC' if Siteclient.table_exists?),
                :title_attribute => 'email',
                :xhr_paging => true

	      protected
	      def delete_subscriber
	        RestClient.delete("https://api:key-01438838a0123e4a65db5796cd166a73" \
	        "@api.mailgun.net/v3/lists/subscribers@mailgun.marinerus.ru/members" \
	        "/#{@siteclient.email}")
	      end

        # def find_all_ships
        #   @ships = Siteclient.all
        # end

      end
    end
  end
end
