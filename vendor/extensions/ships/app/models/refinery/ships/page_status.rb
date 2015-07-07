module Refinery
  module Ships
    class PageStatus < Refinery::Core::BaseModel
      self.table_name = 'page_statuss'

      has_many :ships
    end
  end
end
