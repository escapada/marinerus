class AddNewPaperclipModelDoc < ActiveRecord::Migration
  def up
	create_table :ship_docs do |t|
	t.integer :attachment_id
	t.attachment :doc

	t.timestamps
    end
  end

  def down
  	drop_table :ship_docs
  end
end
