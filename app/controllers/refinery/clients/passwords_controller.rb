module Refinery
  module Clients
    class PasswordsController < Devise::PasswordsController
    	layout 'refinery/clients/layouts/login'
    	
    end
  end
end