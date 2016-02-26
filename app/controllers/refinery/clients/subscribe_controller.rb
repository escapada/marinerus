module Refinery
	module Clients
		class SubscribeController < ::ApplicationController#::ActionController::Base 

			################### this controller is not used yet

			def subscribed
				response = RestClient.post("https://api:key-2b931b07a70d72df02e817bc79e9a8ba" \
				"@api.mailgun.net/v3/lists/unregistered_subscribers@mailgun.marinerus.ru/members",
				:upsert => true,
				:address => email,
				:subscribed => mail_me)

				# response.code == 200 ? return true : false
			end

			# def unsubscribed
			# 	response = RestClient.post("https://api:key-2b931b07a70d72df02e817bc79e9a8ba" \
			# 	"@api.mailgun.net/v3/lists/subscribers@mailgun.marinerus.ru/members",
			# 	:upsert => true,
			# 	:address => params[:email]
			# 	:subscribed => false)
			# end
		end
	end
end