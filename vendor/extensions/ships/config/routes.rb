Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :ships do
    resources :ships, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :ships, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :ships, :except => :show do
        collection do
          post :update_positions
        end
      match 'sendshipmail', to: 'ships#send_ship_to_subscribers', :as => :sendshipmail, via: [:post]
      end
    end
  end

end
