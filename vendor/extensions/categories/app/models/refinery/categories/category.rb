module Refinery
  module Categories
    class Category < Refinery::Core::BaseModel
      self.table_name = 'refinery_categories'

      attr_accessible :rutitle, :entitle, :position

      validates :rutitle, :presence => true, :uniqueness => true

      has_many :ships, :class_name=>'Refinery::Ships::Ship'
    end
  end
end
