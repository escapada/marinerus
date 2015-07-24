# This migration comes from refinery_ships (originally 1)
class CreateShipsShips < ActiveRecord::Migration

  def up
    create_table :refinery_ships do |t|
      t.string :title
      t.string :meta
      t.integer :client_id
      t.integer :category_id
      t.integer :page_status_id, :default=>1
      t.integer :status_id
      t.integer :condition_id
      t.integer :area_id
      t.integer :registration_id
      t.integer :registr_id
      t.integer :engine_id
      t.integer :power_id
      t.integer :propulsion_id
      t.integer :fuel_id
      t.integer :speed_id
      t.integer :gmdss_id
      t.integer :hulltype_id
      t.integer :hullmaterial_id
      t.integer :supermaterial_id
      t.integer :tanksheatingchoice_id
      t.integer :tankscoolingchoice_id
      t.integer :doubleboardchoice_id
      t.integer :doublebottomchoice_id
      t.integer :doublehullchoice_id
      t.integer :currency_id
      t.integer :vat_id


      t.string :owner
      t.string :operator
      t.string :register_number
      t.string :tbn
      t.string :subtype
      t.string :appointment
      t.string :project
      t.string :flag
      t.date :construction_date
      t.string :construction_place
      t.date :renovation_date
      t.string :registr_symbol
      t.date :period_class
      t.date :last_dock
      t.date :next_dock
      t.float :length
      t.float :width
      t.float :height
      t.float :free_board
      t.float :max_draught
      t.float :min_draught
      t.float :air_draught
      t.float :gross_tonnage
      t.float :net_tonnage
      t.float :deadweight
      t.float :loading
      t.float :displacement
      t.float :dockweight
      t.integer :tanks
      t.float :tanksvolume
      t.integer :passengers
      t.string :enginemodel
      t.integer :enginequantity
      t.float :enginepower
      t.integer :propulsionquantity
      t.float :fuelcapacity
      t.float :fuel_way
      t.float :fuel_port
      t.string :autonomy
      t.float :speed
      t.integer :crew
      t.string :diesel
      t.string :sternthrusters
      t.string :stabilizers
      t.string :winch
      t.string :hook
      t.float :cablelength
      t.integer :cranes
      t.float :craneloading
      t.integer :sails
      t.float :sailsarea
      t.string :location
      t.decimal :price, precision: 10, scale: 2
      t.string :info
      t.integer :position

      t.timestamps
    end

    Refinery::Ships::Ship.create_translation_table! :title => :string, :meta => :string, :owner => :string, :operator => :string, :register_number => :string, :tbn => :string, :subtype => :string, :appointment => :string, :project => :string, :flag => :string, :construction_place => :string, :registr_symbol => :string, :enginemodel => :string, :autonomy => :string, :diesel => :string, :sternthrusters => :string, :stabilizers => :string, :winch => :string, :hook => :string, :location => :string, :info => :string

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
    create_table :speeds do |t|
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
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-ships"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/ships/ships"})
    end

    drop_table :refinery_ships
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
    drop_table :speeds
    drop_table :gmdsss
    drop_table :currencies
    drop_table :vats
    drop_table :hulltypes
    drop_table :hullmaterials
    drop_table :choices

    Refinery::Ships::Ship.drop_translation_table!

  end

end
