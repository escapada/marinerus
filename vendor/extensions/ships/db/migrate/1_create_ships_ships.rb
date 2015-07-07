class CreateShipsShips < ActiveRecord::Migration

  def up
    create_table :refinery_ships do |t|
      t.string :title
      t.string :meta
      t.integer :client_id
      t.integer :category_id
      t.string :page_status
      t.string :owner
      t.string :operator
      t.string :register_number
      t.string :tbn
      t.string :status
      t.string :condition
      t.string :area
      t.string :subtype
      t.string :appointment
      t.string :project
      t.string :flag
      t.string :registration
      t.date :construction_date
      t.string :construction_place
      t.date :renovation_date
      t.string :registr
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
      t.string :enginetype
      t.string :enginemodel
      t.integer :enginequantity
      t.float :enginepower
      t.string :enginepowername
      t.string :propulsion
      t.integer :propulsionquantity
      t.float :fuelfuelcapacity
      t.float :fuel_way
      t.float :fuel_port
      t.string :autonomy
      t.float :speed
      t.string :speedname
      t.string :gmdss
      t.decimal :crewprice
      t.string :crewpricename
      t.string :crewpricetax
      t.string :hulltype
      t.string :hullmaterial
      t.string :supermaterial
      t.string :tanksheating
      t.string :tankscooling
      t.string :double_board
      t.string :double_bottom
      t.string :double_hull
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
      t.decimal :price
      t.string :pricename
      t.string :pricetax
      t.string :info
      t.integer :position

      t.timestamps
    end

    Refinery::Ships::Ship.create_translation_table! :title => :string, :meta => :string, :owner => :string, :operator => :string, :register_number => :string, :tbn => :string, :subtype => :string, :appointment => :string, :project => :string, :flag => :string, :construction_place => :string, :registr_symbol => :string, :enginemodel => :string, :autonomy => :string, :diesel => :string, :sternthrusters => :string, :stabilizers => :string, :winch => :string, :hook => :string, :location => :string, :info => :string

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-ships"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/ships/ships"})
    end

    drop_table :refinery_ships

    Refinery::Ships::Ship.drop_translation_table!

  end

end
