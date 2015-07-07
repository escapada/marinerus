module Refinery
  module Ships
    class Power < Refinery::Core::BaseModel
      self.table_name = 'powers'

      has_many :ships
    end
  end
end
