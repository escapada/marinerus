module Refinery
  module Ships
    class Fuel < Refinery::Core::BaseModel
      self.table_name = 'fuels'

      has_many :ships
    end
  end
end
