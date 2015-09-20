class AddLotIdFieldToInquiry < ActiveRecord::Migration
  def change
  	add_column :refinery_inquiries_inquiries, :lot_id, :integer
  end
end