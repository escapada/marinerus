module Refinery
  module Ships
    class Speed < Refinery::Core::BaseModel
      self.table_name = 'speeds'

      has_many :ships
    end
  end
end
