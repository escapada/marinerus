module Refinery
  module Ships
    class Hulltype < Refinery::Core::BaseModel
      self.table_name = 'hulltypes'

      has_many :ships
    end
  end
end
