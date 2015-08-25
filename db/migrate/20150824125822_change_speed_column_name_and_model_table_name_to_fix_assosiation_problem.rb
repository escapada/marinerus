class ChangeSpeedColumnNameAndModelTableNameToFixAssosiationProblem < ActiveRecord::Migration
  def up
  	rename_column :refinery_ships, :speed_id, :speedname_id
  	rename_table :speeds, :speednames
  end

  def down
  	rename_column :refinery_ships, :speedname_id, :speed_id
  	rename_table :speednames, :speeds
  end
end
