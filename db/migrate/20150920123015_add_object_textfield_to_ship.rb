class AddObjectTextfieldToShip < ActiveRecord::Migration
  def change
  	add_column :refinery_ships, :object, :text
  	add_column :refinery_ship_translations, :object, :text
  end
end