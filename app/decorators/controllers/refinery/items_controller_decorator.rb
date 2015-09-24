Refinery::News::ItemsController.class_eval do

      def show
        # render 'show'
        present(@item) #to show news title in title tag
      end
      
end
