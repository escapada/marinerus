module Refinery
  module Ships
    class Speedname < Refinery::Core::BaseModel
      self.table_name = 'speednames'

      has_many :ships
    end
  end
end
