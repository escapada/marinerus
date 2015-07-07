module Refinery
  module Ships
    class Condition < Refinery::Core::BaseModel
      self.table_name = 'conditions'

      has_many :ships
    end
  end
end
