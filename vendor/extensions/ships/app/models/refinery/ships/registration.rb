module Refinery
  module Ships
    class Registration < Refinery::Core::BaseModel
      self.table_name = 'registrations'

      has_many :ships
    end
  end
end
