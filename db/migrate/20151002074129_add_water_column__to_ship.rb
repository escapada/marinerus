class AddWaterColumnToShip < ActiveRecord::Migration
  def change
  	add_column :refinery_ships, :water, :integer
  end
end
