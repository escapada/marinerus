class CreateSearchesTable < ActiveRecord::Migration
  def up
	create_table :searches do |t|
		t.integer :status_id
		t.integer :category_id
		t.integer :area_id
		t.integer :currency_id
		t.integer :power_id
		t.string :title
		t.string :flag
		t.string :project

		t.date :first_date
		t.date :last_date

		t.string :first_length
		t.string :last_length

		t.string :first_max_draught
		t.string :last_max_draught

		t.string :first_deadweight
		t.string :last_deadweight

		t.string :first_price
		t.string :last_price

		t.string :first_power
		t.string :last_power

		t.string :first_passengers
		t.string :last_passengers

		t.timestamps
	end
  end

  def down
  	drop_table :searches
  end
end