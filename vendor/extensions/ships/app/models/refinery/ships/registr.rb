module Refinery
  module Ships
    class Registr < Refinery::Core::BaseModel
      self.table_name = 'registrs'

      has_many :ships
    end
  end
end
