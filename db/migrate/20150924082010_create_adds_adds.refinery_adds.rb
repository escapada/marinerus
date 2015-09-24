# This migration comes from refinery_adds (originally 1)
class CreateAddsAdds < ActiveRecord::Migration

  def up
    create_table :refinery_adds do |t|
      t.string :title
      t.integer :image_id
      t.text :body
      t.integer :position

      t.timestamps
    end

    Refinery::Adds::Add.create_translation_table! :title => :string, :body => :text

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-adds"})
    end

    drop_table :refinery_adds

    Refinery::Adds::Add.drop_translation_table!

  end

end
