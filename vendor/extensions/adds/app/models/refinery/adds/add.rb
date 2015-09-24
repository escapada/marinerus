module Refinery
  module Adds
    class Add < Refinery::Core::BaseModel
      self.table_name = 'refinery_adds'

      attr_accessible :title, :image_id, :body, :position

      translates :title, :body

      class Translation
        attr_accessible :locale
      end

      validates :title, :presence => true, :uniqueness => true

      belongs_to :image, :class_name => '::Refinery::Image'
    end
  end
end
