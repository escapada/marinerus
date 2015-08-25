module Refinery
  module Ships
    class Search < Refinery::Core::BaseModel
      self.table_name = 'searches'

      attr_accessible	:status_id, :category_id, :area_id, :currency_id, :power_id, :title, :flag, :project, :first_date, :last_date, :first_date, :last_date, :first_length, :last_length, :first_max_draught, :last_max_draught, :first_deadweight, :last_deadweight, :first_price, :last_price, :first_power, :last_power, :first_passengers, :last_passengers

      #first_length, #last_length, #first_max_draught, #last_max_draught, #first_deadweight, #last_deadweight, #first_price, #last_price, #first_power, #last_power, #first_passengers, #last_passengers, #first_date__1i, #last_date__1i

      belongs_to :status
      belongs_to :category
      belongs_to :area
      belongs_to :currency
      belongs_to :power

    end
  end
end
