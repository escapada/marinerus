class AddAllAnotherTablesForModelsHelpers < ActiveRecord::Migration
  def up
  	create_table :page_statuss do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :statuss do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :conditions do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :areas do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :registrations do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :registrs do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :engines do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :powers do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :propulsions do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :fuels do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :speednames do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :gmdsss do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :currencies do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :vats do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :hulltypes do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :hullmaterials do |t|
      t.string :rutitle
      t.string :entitle
    end
    create_table :choices do |t|
      t.string :rutitle
      t.string :entitle
    end
  end

  def down
	drop_table :page_statuss
	drop_table :statuss
	drop_table :conditions
	drop_table :areas
	drop_table :registrations
	drop_table :registrs
	drop_table :engines
	drop_table :powers
	drop_table :propulsions
	drop_table :fuels
	drop_table :speednames
	drop_table :gmdsss
	drop_table :currencies
	drop_table :vats
	drop_table :hulltypes
	drop_table :hullmaterials
	drop_table :choices
  end
end
