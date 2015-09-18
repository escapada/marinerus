module Refinery
  module Ships
    class Ship < Refinery::Core::BaseModel
      self.table_name = 'refinery_ships'

      attr_accessible :title, :on_the_main_flag, :meta, :client_id, :category_id, :page_status_id, :owner, :operator, :register_number, :tbn, :status_id, :condition_id, :area_id, :subtype, :appointment, :project, :flag, :registration_id, :construction_date, :construction_place, :renovation_date, :registr_id, :registr_symbol, :period_class, :last_dock, :next_dock, :length, :width, :height, :free_board, :max_draught, :min_draught, :air_draught, :gross_tonnage, :net_tonnage, :deadweight, :loading, :displacement, :dockweight, :tanks, :tanksvolume, :passengers, :engine_id, :enginemodel, :enginequantity, :enginepower, :power_id, :propulsion_id, :propulsionquantity, :fuel_id, :fuelcapacity, :fuel_way, :fuel_port, :autonomy, :speed, :speedname_id, :gmdss_id, :crew, :hulltype_id, :hullmaterial_id, :supermaterial_id, :tanksheatingchoice_id, :tankscoolingchoice_id, :doubleboardchoice_id, :doublebottomchoice_id, :doublehullchoice_id, :diesel, :sternthrusters, :stabilizers, :winch, :hook, :cablelength, :cranes, :craneloading, :sails, :sailsarea, :location, :price, :currency_id, :vat_id, :info, :position

      translates :title, :meta, :owner, :operator, :register_number, :tbn, :subtype, :appointment, :project, :flag, :construction_place, :registr_symbol, :enginemodel, :autonomy, :diesel, :sternthrusters, :stabilizers, :winch, :hook, :location, :info

      class Translation
        attr_accessible :locale
      end

      validates :title, :presence => true, :uniqueness => true
      # validates :category_id, :presence => true

      has_one :attachment, :class_name=>'Refinery::Ships::Attachment'

      belongs_to :category, :class_name=>'Refinery::Categories::Category'

      belongs_to :client, :class_name=>'Refinery::Clients::Client'
      belongs_to :page_status, :class_name=>'Refinery::Ships::PageStatus'
      belongs_to :status, :class_name=>'Refinery::Ships::Status'
      belongs_to :area, :class_name=>'Refinery::Ships::Area'

      belongs_to :hullmaterial, :class_name=>'Refinery::Ships::Hullmaterial'
      belongs_to :supermaterial, :class_name=>'Refinery::Ships::Hullmaterial'
      belongs_to :tanksheating, :class_name=>'Refinery::Ships::Choice'
      belongs_to :tankscooling, :class_name=>'Refinery::Ships::Choice'
      belongs_to :double_board, :class_name=>'Refinery::Ships::Choice'
      belongs_to :double_bottom, :class_name=>'Refinery::Ships::Choice'
      belongs_to :double_hull, :class_name=>'Refinery::Ships::Choice'
      
      belongs_to :condition, :class_name=>'Refinery::Ships::Condition'
      belongs_to :currency, :class_name=>'Refinery::Ships::Currency'
      belongs_to :enginetype, :class_name=>'Refinery::Ships::Enginetype'
      belongs_to :fuel, :class_name=>'Refinery::Ships::Fuel'
      belongs_to :gmdss, :class_name=>'Refinery::Ships::Gmdss'
      belongs_to :hulltype, :class_name=>'Refinery::Ships::Hulltype'
      belongs_to :power, :class_name=>'Refinery::Ships::Power'
      belongs_to :propulsion, :class_name=>'Refinery::Ships::Propulsion'
      belongs_to :registration, :class_name=>'Refinery::Ships::Registration'
      belongs_to :registr, :class_name=>'Refinery::Ships::Registr'
      belongs_to :speedname, :class_name=>'Refinery::Ships::Speedname'
      belongs_to :vat, :class_name=>'Refinery::Ships::Vat'

      #belongs_to :client, :category, :page_status, :status, :condition, :area, :fuel, :gmdss, :hulltype, :power, :propulsion, :registr, :registration, :speed
      #belongs_to :enginetype, :foreign_key=>:engine_id

      def self.search(params)
        if params[:search]
          search = params[:search]

          sh = Ship.includes(:translations).where("page_status_id = 2 AND (status_id IN (1,2,3,7,8))")

          sh = sh.where(["refinery_ship_translations.info LIKE ?", "%#{search[:info]}%"]) if (search[:info].present? and params[:locale].to_s=="en")
          sh = sh.where(["info LIKE ?", "%#{search[:info]}%"]) if (search[:info].present? and params[:locale].to_s=="ru")
          # advanced search next
          sh = sh.where(["refinery_ship_translations.project LIKE ?", "%#{search[:project]}%"]) if (search[:project].present? and params[:locale].to_s=="en")
          sh = sh.where(["project LIKE ?", "%#{search[:project]}%"]) if (search[:project].present? and params[:locale].to_s=="ru")

          sh = sh.where(["refinery_ship_translations.flag LIKE ?", "%#{search[:flag]}%"]) if (search[:flag].present? and params[:locale].to_s=="en")
          sh = sh.where(["flag LIKE ?", "%#{search[:flag]}%"]) if (search[:flag].present? and params[:locale].to_s=="ru")

          sh = sh.where(["category_id = ?", search[:category_id]]) if search[:category_id].present?
          sh = sh.where(["status_id = ?", search[:status_id]]) if search[:status_id].present?
          sh = sh.where(["area_id = ?", search[:area_id]]) if search[:area_id].present?

          sh = sh.where(["construction_date >= ? OR construction_date IS NULL", (search["first_date(3i)"]+"."+search["first_date(2i)"]+"."+search["first_date(1i)"]).to_date]) if search["first_date(1i)"].present?
          sh = sh.where(["construction_date <= ? OR construction_date IS NULL", (search["last_date(3i)"]+"."+search["last_date(2i)"]+"."+search["last_date(1i)"]).to_date]) if search["last_date(1i)"].present?

          sh = sh.where(["length >= ? OR length IS NULL", search[:first_length]]) if search[:first_length].present?
          sh = sh.where(["length <= ? OR length IS NULL", search[:last_length]]) if search[:last_length].present?

          sh = sh.where(["max_draught >= ? OR max_draught IS NULL", search[:first_max_draught]]) if search[:first_max_draught].present?
          sh = sh.where(["max_draught <= ? OR max_draught IS NULL", search[:last_max_draught]]) if search[:last_max_draught].present?

          sh = sh.where(["deadweight >= ? OR deadweight IS NULL", search[:first_deadweight]]) if search[:first_deadweight].present?
          sh = sh.where(["deadweight <= ? OR deadweight IS NULL", search[:last_deadweight]]) if search[:last_deadweight].present?

          sh = sh.where(["(price >= ? OR price IS NULL) AND currency_id = ?", search[:first_price], search[:currency_id]]) if (search[:first_price].present? and search[:currency_id].present?)
          sh = sh.where(["(price <= ? OR price IS NULL) AND currency_id = ?", search[:last_price], search[:currency_id]]) if (search[:last_price].present? and search[:currency_id].present?)

          sh = sh.where(["(enginepower >= ? OR enginepower IS NULL) AND power_id = ?", search[:first_enginepower], search[:power_id]]) if (search[:first_enginepower].present? and search[:power_id].present?) 
          sh = sh.where(["(enginepower <= ? OR enginepower IS NULL) AND power_id = ?", search[:last_enginepower], search[:power_id]]) if (search[:last_enginepower].present? and search[:power_id].present?)

          sh = sh.where(["passengers >= ? OR passengers IS NULL", search[:first_passengers]]) if search[:first_passengers].present?
          sh = sh.where(["passengers <= ? OR passengers IS NULL", search[:last_passengers]]) if search[:last_passengers].present?

          return sh

        else
          includes(:translations).where("page_status_id = 2 AND (status_id IN (1,2,3,7,8))")
        end
      end

    end
  end
end
