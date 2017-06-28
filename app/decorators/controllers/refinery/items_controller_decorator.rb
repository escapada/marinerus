Refinery::News::ItemsController.class_eval do
	layout 'subscribing', :only=>[:send_news_to_subscribers]
	before_filter :adds_find
	before_filter	:update_mailing_list, :only=>[:send_news_to_subscribers]

	def show
		# render 'show'
		present(@item) #to show news title in title tag
	end

	def adds_find
		@adds = Refinery::Adds::Add.limit(4)
		@adds.order(:positions) if @adds.present?
	end

  def send_news_to_subscribers
		@item = Refinery::News::Item.where(id:params[:id]).first

		data = Multimap.new
		data[:from] = "marinerus <no-reply@marinerus.ru>"
		data[:to] = "subscribers@mailgun.marinerus.ru, unregistered_subscribers@mailgun.marinerus.ru"
		# data[:to] = "escapada83@yandex.ru"
		data[:subject] = "News / Новости"
		# data[:text] = "Testing some shit!"
		data[:html] = render_to_string :newsmailing # "<html><body><img src='http://marinerus.ru/assets/logo.png' /></body></html>"
		#data[:attachment] = File.new(File.join("files", "test.jpg"))
		#data[:attachment] = File.new(File.join("files", "test.txt"))

		response = RestClient.post "https://api:key-01438838a0123e4a65db5796cd166a73"\
		"@api.mailgun.net/v3/mailgun.marinerus.ru/messages",
		data.to_hash
		logger.debug(render_to_string :newsmailing)
		# logger.debug(data.to_hash)
		respond_to do |format|
			format.js {
				response.code == 200 ? flash.now[:notice] = "Письмо отправлено!" : flash.now[:notice] = "Не удалось отправить. Попробуйте позже."
			}
		end
	end

	protected

	# next update_mailing_list is now using (correct multiple Mailgun mailing list update)
	# see all Mailgun methods working with subscribers in ClientController

	def update_mailing_list
		clients = Refinery::Clients::Client.all
		subscribers = clients.map {|c| {"address" => c.email, "subscribed" => c.mail_me}}

		subscribers.in_groups_of(200, false) do |s|
			RestClient.post("https://api:key-01438838a0123e4a65db5796cd166a73" \
			"@api.mailgun.net/v3/lists/subscribers@mailgun.marinerus.ru/members.json",
			:upsert => true,
			:members => s.to_json)
		end
	end
      
end
