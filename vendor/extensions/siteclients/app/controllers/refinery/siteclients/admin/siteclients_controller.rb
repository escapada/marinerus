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
	        RestClient.delete("https://api:key-2b931b07a70d72df02e817bc79e9a8ba" \
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
