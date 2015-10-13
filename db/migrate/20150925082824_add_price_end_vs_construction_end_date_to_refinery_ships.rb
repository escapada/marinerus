class AddPriceEndVsConstructionEndDateToRefineryShips < ActiveRecord::Migration
  def change
  	add_column :refinery_ships, :construction_end_date, :date
  	add_column :refinery_ships, :price_end, :decimal
  end
end
