module Refinery
  module Ships
    class Status < Refinery::Core::BaseModel
      self.table_name = 'statuss'

      has_many :ships
    end
  end
end
