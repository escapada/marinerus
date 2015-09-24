module Refinery
  module Adds
    module Admin
      class AddsController < ::Refinery::AdminController

        crudify :'refinery/adds/add',
                :xhr_paging => true

      end
    end
  end
end
