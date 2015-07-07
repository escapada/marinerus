module Refinery
  module Ships
    class Ship < Refinery::Core::BaseModel
      self.table_name = 'refinery_ships'

      attr_accessible :title, :meta, :client_id, :category_id, :page_status_id, :owner, :operator, :register_number, :tbn, :status_id, :condition_id, :area_id, :subtype, :appointment, :project, :flag, :registration_id, :construction_date, :construction_place, :renovation_date, :registr_id, :registr_symbol, :period_class, :last_dock, :next_dock, :length, :width, :height, :free_board, :max_draught, :min_draught, :air_draught, :gross_tonnage, :net_tonnage, :deadweight, :loading, :displacement, :dockweight, :tanks, :tanksvolume, :passengers, :engine_id, :enginemodel, :enginequantity, :enginepower, :power_id, :propulsion_id, :propulsionquantity, :fuel_id, :fuelcapacity, :fuel_way, :fuel_port, :autonomy, :speed, :speed_id, :gmdss_id, :crewprice, :crewcurrency_id, :crewvat_id, :hulltype_id, :hullmaterial_id, :supermaterial_id, :tanksheatingchoice_id, :tankscoolingchoice_id, :doubleboardchoice_id, :doublebottomchoice_id, :doublehullchoice_id, :diesel, :sternthrusters, :stabilizers, :winch, :hook, :cablelength, :cranes, :craneloading, :sails, :sailsarea, :location, :price, :currency_id, :vat_id, :info, :position

      translates :title, :meta, :owner, :operator, :register_number, :tbn, :subtype, :appointment, :project, :flag, :construction_place, :registr_symbol, :enginemodel, :autonomy, :diesel, :sternthrusters, :stabilizers, :winch, :hook, :location, :info

      class Translation
        attr_accessible :locale
      end

      validates :title, :presence => true, :uniqueness => true

      belongs_to :client, :class_name=>'Refinery::Clients::Client'

      #belongs_to :client, :category, :page_status, :status, :condition, :area, :fuel, :gmdss, :hulltype, :power, :propulsion, :registr, :registration, :speed
      #belongs_to :enginetype, :foreign_key=>:engine_id
    end
  end
end
