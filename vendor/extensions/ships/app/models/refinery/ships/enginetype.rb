module Refinery
  module Ships
    class Enginetype < Refinery::Core::BaseModel
      self.table_name = 'engines'

      has_many :ships
    end
  end
end
