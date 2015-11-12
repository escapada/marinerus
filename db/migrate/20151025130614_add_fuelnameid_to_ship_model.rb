class AddFuelnameidToShipModel < ActiveRecord::Migration
  def change
  	add_column :refinery_ships, :fuelname_id, :integer
  end
end
