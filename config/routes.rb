Refinery::Core::Engine.routes.prepend do

  devise_for :clients,  :class_name => "Refinery::Clients::Client",
                                :controllers => {:sessions => 'refinery/clients/sessions', :passwords => 'refinery/clients/passwords', :registrations => 'refinery/clients/registrations', :confirmations => 'refinery/clients/confirmations'}


  devise_scope :client do
      get "/clients/change_psw", :to => "clients/registrations#edit_password", :as => :edit_password
      match 'raptcha(/:action)', to: 'clients/registrations#raptcha_generate'
  end

  get "/clients/office", :to => "clients/office#index", :as => :office

  namespace :clients do
    resources :ships, controller: 'ships'
    match 'uploadfile', to: 'upload#create_file', :as => :uploadfile, via: [:post]
    match 'uploadphoto', to: 'upload#create_photo', :as => :uploadphoto, via: [:post]
    # some AJAX links
    match 'deletefile', to: 'upload#delete_file', :as => :deletefile, via: [:post]
    match 'deletephoto', to: 'upload#delete_photo', :as => :deletephoto, via: [:post]

    # some Subscribing actions not in use
    match 'subscribed', to: 'subscribe#subscribed', :as => :subscribed, via: [:post]
    match 'unsubscribed', to: 'subscribe#unsubscribed', :as => :unsubscribed, via: [:post]
    # match 'delete_subscriber', to: 'subscribe#delete_subscriber', :as => :delete_subscriber, via: [:delete]
  end
  match 'sendnewsmail/:id', to: 'news/items#send_news_to_subscribers', :as => :sendnewsmail
  # match 'raptcha(/:action)' => 'raptcha'
  #map.raptcha '/raptcha', :controller => 'blogs', :action => 'captcha'


end

Refinery::Ships::Engine.routes.prepend do
  devise_for :clients,  :class_name => "Refinery::Clients::Client",
                                :controllers => {:office => 'refinery/clients/office', :sessions => 'refinery/clients/sessions', :passwords => 'refinery/clients/passwords', :registrations => 'refinery/clients/registrations', :confirmations => 'refinery/clients/confirmations'}
  devise_scope :client do
      get "/clients/office", :to => "clients/office#index", :as => :office
  end

  ##
  namespace :clients do
    resources :ships, controller: 'ships'
    match 'uploadfile', to: 'upload#create_file', :as => :uploadfile, via: [:post]
    match 'uploadphoto', to: 'upload#create_photo', :as => :uploadphoto, via: [:post]
    # some AJAX links
    match 'deletefile', to: 'upload#delete_file', :as => :deletefile, via: [:post]
    match 'deletephoto', to: 'upload#delete_photo', :as => :deletephoto, via: [:post]
  end
  ##
end

Refinery::Inquiries::Engine.routes.prepend do
  devise_for :clients,  :class_name => "Refinery::Clients::Client",
                                :controllers => {:office => 'refinery/clients/office', :sessions => 'refinery/clients/sessions', :passwords => 'refinery/clients/passwords', :registrations => 'refinery/clients/registrations', :confirmations => 'refinery/clients/confirmations'}
  devise_scope :client do
      get "/clients/office", :to => "clients/office#index", :as => :office
  end
end

Refinery::News::Engine.routes.prepend do
  devise_for :clients,  :class_name => "Refinery::Clients::Client",
                                :controllers => {:office => 'refinery/clients/office', :sessions => 'refinery/clients/sessions', :passwords => 'refinery/clients/passwords', :registrations => 'refinery/clients/registrations', :confirmations => 'refinery/clients/confirmations'}
  devise_scope :client do
      get "/clients/office", :to => "clients/office#index", :as => :office
  end
end

Marinerus::Application.routes.draw do

  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"
  mount Refinery::Core::Engine, :at => '/'

#devise_for :clients,  :class_name => "Refinery::Clients::Client"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
