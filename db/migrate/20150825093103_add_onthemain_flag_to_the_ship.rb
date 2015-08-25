class AddOnthemainFlagToTheShip < ActiveRecord::Migration
  def up
  	add_column :refinery_ships, :on_the_main_flag, :boolean, :default => 0
  end

  def down
  	remove_column :refinery_ships, :on_the_main_flag
  end
end
