class CreateCategoriesCategories < ActiveRecord::Migration

  def up
    create_table :refinery_categories do |t|
      t.string :rutitle
      t.string :entitle
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-categories"})
    end

    drop_table :refinery_categories

  end

end
