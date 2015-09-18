class AddInfoFieldToSearchModel < ActiveRecord::Migration
  def change
  	add_column :searches, :info, :string
  end
end
