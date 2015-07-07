module Refinery
  module Ships
    class Area < Refinery::Core::BaseModel
      self.table_name = 'areas'

      has_many :ships
    end
  end
end
