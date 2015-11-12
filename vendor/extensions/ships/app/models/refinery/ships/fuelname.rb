module Refinery
  module Ships
    class Fuelname < Refinery::Core::BaseModel
      self.table_name = 'fuelnames'

      has_many :ships
    end
  end
end
