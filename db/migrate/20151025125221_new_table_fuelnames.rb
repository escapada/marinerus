class NewTableFuelnames < ActiveRecord::Migration
  def up
  	create_table :fuelnames do |t|
	      t.string :rutitle
	      t.string :entitle
    end
  end

  def down
  	drop_table :fuelnames
  end
end