module Refinery
  module Projects
    class Project < Refinery::Core::BaseModel
      self.table_name = 'refinery_projects'

      attr_accessible :title, :description, :position

      translates :title, :description

      class Translation
        attr_accessible :locale
      end

      validates :title, :presence => true, :uniqueness => true
    end
  end
end
