module Refinery
  module Ships
    class Gmdss < Refinery::Core::BaseModel
      self.table_name = 'gmdsss'

      has_many :ships
    end
  end
end
