Refinery::News::ItemsController.class_eval do
	before_filter :adds_find

	def show
		# render 'show'
		present(@item) #to show news title in title tag
	end

	def adds_find
		@adds = Refinery::Adds::Add.limit(4)
	end
      
end
