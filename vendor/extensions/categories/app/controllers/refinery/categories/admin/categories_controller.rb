module Refinery
  module Categories
    module Admin
      class CategoriesController < ::Refinery::AdminController

        crudify :'refinery/categories/category',
                :title_attribute => 'rutitle',
                :xhr_paging => true

      end
    end
  end
end
