class CreateAttachmentFilePhotoModels < ActiveRecord::Migration
  def up
  	create_table :attachments do |t|
      t.integer :ship_id
      t.integer :client_id

      t.timestamps
    end
    create_table :ship_files do |t|
      t.integer :attachment_id
      t.attachment :file

      t.timestamps
    end
    create_table :ship_photos do |t|
      t.integer :attachment_id
      t.attachment :photo

      t.timestamps
    end
  end

  def down
  	drop_table :attachments
  	drop_table :ship_files
  	drop_table :ship_photos
  end
end
