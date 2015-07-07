module Refinery
  module Ships
    class Propulsion < Refinery::Core::BaseModel
      self.table_name = 'propulsions'

      has_many :ships
    end
  end
end
