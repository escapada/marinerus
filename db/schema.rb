# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20160613151628) do

  create_table "areas", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "attachments", :force => true do |t|
    t.integer  "ship_id"
    t.integer  "client_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "choices", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "conditions", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "currencies", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "engines", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "fuelnames", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "fuels", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "gmdsss", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "hullmaterials", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "hulltypes", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "page_statuss", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "powers", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "propulsions", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "refinery_add_translations", :force => true do |t|
    t.integer  "refinery_add_id"
    t.string   "locale",          :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "title"
    t.text     "body"
  end

  add_index "refinery_add_translations", ["locale"], :name => "index_refinery_add_translations_on_locale"
  add_index "refinery_add_translations", ["refinery_add_id"], :name => "index_refinery_add_translations_on_refinery_add_id"

  create_table "refinery_adds", :force => true do |t|
    t.string   "title"
    t.integer  "image_id"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "refinery_categories", :force => true do |t|
    t.string   "rutitle"
    t.string   "entitle"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "refinery_clients", :force => true do |t|
    t.string   "email",                  :default => "",   :null => false
    t.string   "name"
    t.string   "company"
    t.string   "job"
    t.string   "phone"
    t.boolean  "mail_me",                :default => true
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "position"
  end

  add_index "refinery_clients", ["confirmation_token"], :name => "index_refinery_clients_on_confirmation_token", :unique => true
  add_index "refinery_clients", ["email"], :name => "index_refinery_clients_on_email", :unique => true
  add_index "refinery_clients", ["reset_password_token"], :name => "index_refinery_clients_on_reset_password_token", :unique => true

  create_table "refinery_images", :force => true do |t|
    t.string   "image_mime_type"
    t.string   "image_name"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_uid"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "refinery_inquiries_inquiries", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.boolean  "spam",       :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "lot_id"
  end

  add_index "refinery_inquiries_inquiries", ["id"], :name => "index_refinery_inquiries_inquiries_on_id"

  create_table "refinery_news_item_translations", :force => true do |t|
    t.integer  "refinery_news_item_id"
    t.string   "locale",                :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "title"
    t.text     "body"
    t.string   "source"
    t.string   "slug"
  end

  add_index "refinery_news_item_translations", ["locale"], :name => "index_refinery_news_item_translations_on_locale"
  add_index "refinery_news_item_translations", ["refinery_news_item_id"], :name => "index_refinery_news_item_translations_fk"

  create_table "refinery_news_items", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "publish_date"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "image_id"
    t.datetime "expiration_date"
    t.string   "source"
    t.string   "slug"
  end

  add_index "refinery_news_items", ["id"], :name => "index_refinery_news_items_on_id"

  create_table "refinery_page_part_translations", :force => true do |t|
    t.integer  "refinery_page_part_id"
    t.string   "locale",                :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.text     "body"
  end

  add_index "refinery_page_part_translations", ["locale"], :name => "index_refinery_page_part_translations_on_locale"
  add_index "refinery_page_part_translations", ["refinery_page_part_id"], :name => "index_refinery_page_part_translations_on_refinery_page_part_id"

  create_table "refinery_page_parts", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_parts", ["id"], :name => "index_refinery_page_parts_on_id"
  add_index "refinery_page_parts", ["refinery_page_id"], :name => "index_refinery_page_parts_on_refinery_page_id"

  create_table "refinery_page_translations", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "locale",           :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "title"
    t.string   "custom_slug"
    t.string   "menu_title"
    t.string   "slug"
  end

  add_index "refinery_page_translations", ["locale"], :name => "index_refinery_page_translations_on_locale"
  add_index "refinery_page_translations", ["refinery_page_id"], :name => "index_refinery_page_translations_on_refinery_page_id"

  create_table "refinery_pages", :force => true do |t|
    t.integer  "parent_id"
    t.string   "path"
    t.string   "slug"
    t.boolean  "show_in_menu",        :default => true
    t.string   "link_url"
    t.string   "menu_match"
    t.boolean  "deletable",           :default => true
    t.boolean  "draft",               :default => false
    t.boolean  "skip_to_first_child", :default => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "view_template"
    t.string   "layout_template"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "refinery_pages", ["depth"], :name => "index_refinery_pages_on_depth"
  add_index "refinery_pages", ["id"], :name => "index_refinery_pages_on_id"
  add_index "refinery_pages", ["lft"], :name => "index_refinery_pages_on_lft"
  add_index "refinery_pages", ["parent_id"], :name => "index_refinery_pages_on_parent_id"
  add_index "refinery_pages", ["rgt"], :name => "index_refinery_pages_on_rgt"

  create_table "refinery_project_translations", :force => true do |t|
    t.integer  "refinery_project_id"
    t.string   "locale",              :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "title"
    t.text     "description"
  end

  add_index "refinery_project_translations", ["locale"], :name => "index_refinery_project_translations_on_locale"
  add_index "refinery_project_translations", ["refinery_project_id"], :name => "index_refinery_project_translations_on_refinery_project_id"

  create_table "refinery_projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "refinery_resources", :force => true do |t|
    t.string   "file_mime_type"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "file_uid"
    t.string   "file_ext"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "refinery_roles", :force => true do |t|
    t.string "title"
  end

  create_table "refinery_roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "refinery_roles_users", ["role_id", "user_id"], :name => "index_refinery_roles_users_on_role_id_and_user_id"
  add_index "refinery_roles_users", ["user_id", "role_id"], :name => "index_refinery_roles_users_on_user_id_and_role_id"

  create_table "refinery_settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.boolean  "destroyable",     :default => true
    t.string   "scoping"
    t.boolean  "restricted",      :default => false
    t.string   "form_value_type"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "slug"
  end

  add_index "refinery_settings", ["name"], :name => "index_refinery_settings_on_name"

  create_table "refinery_ship_translations", :force => true do |t|
    t.integer  "refinery_ship_id"
    t.string   "locale",             :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "title"
    t.string   "meta"
    t.string   "owner"
    t.string   "operator"
    t.string   "register_number"
    t.string   "tbn"
    t.string   "subtype"
    t.string   "appointment"
    t.string   "project"
    t.string   "flag"
    t.string   "construction_place"
    t.string   "registr_symbol"
    t.string   "enginemodel"
    t.string   "autonomy"
    t.string   "diesel"
    t.string   "sternthrusters"
    t.string   "stabilizers"
    t.string   "winch"
    t.string   "hook"
    t.string   "location"
    t.string   "info"
    t.text     "object"
  end

  add_index "refinery_ship_translations", ["locale"], :name => "index_refinery_ship_translations_on_locale"
  add_index "refinery_ship_translations", ["refinery_ship_id"], :name => "index_refinery_ship_translations_on_refinery_ship_id"

  create_table "refinery_ships", :force => true do |t|
    t.boolean  "on_the_main_flag"
    t.string   "title"
    t.string   "meta"
    t.integer  "client_id"
    t.integer  "category_id"
    t.integer  "page_status_id",                                       :default => 1
    t.integer  "status_id"
    t.integer  "condition_id"
    t.integer  "area_id"
    t.integer  "registration_id"
    t.integer  "registr_id"
    t.integer  "engine_id"
    t.integer  "power_id"
    t.integer  "propulsion_id"
    t.integer  "fuel_id"
    t.integer  "speedname_id"
    t.integer  "gmdss_id"
    t.integer  "hulltype_id"
    t.integer  "hullmaterial_id"
    t.integer  "supermaterial_id"
    t.integer  "tanksheatingchoice_id"
    t.integer  "tankscoolingchoice_id"
    t.integer  "doubleboardchoice_id"
    t.integer  "doublebottomchoice_id"
    t.integer  "doublehullchoice_id"
    t.integer  "currency_id"
    t.integer  "vat_id"
    t.string   "owner"
    t.string   "operator"
    t.string   "register_number"
    t.string   "tbn"
    t.string   "subtype"
    t.string   "appointment"
    t.string   "project"
    t.string   "flag"
    t.date     "construction_date"
    t.string   "construction_place"
    t.date     "renovation_date"
    t.string   "registr_symbol"
    t.date     "period_class"
    t.date     "last_dock"
    t.date     "next_dock"
    t.float    "length"
    t.float    "width"
    t.float    "height"
    t.float    "free_board"
    t.float    "max_draught"
    t.float    "min_draught"
    t.float    "air_draught"
    t.float    "gross_tonnage"
    t.float    "net_tonnage"
    t.float    "deadweight"
    t.float    "loading"
    t.float    "displacement"
    t.float    "dockweight"
    t.integer  "tanks"
    t.float    "tanksvolume"
    t.integer  "passengers"
    t.string   "enginemodel"
    t.integer  "enginequantity"
    t.float    "enginepower"
    t.integer  "propulsionquantity"
    t.float    "fuelcapacity"
    t.float    "fuel_way"
    t.float    "fuel_port"
    t.string   "autonomy"
    t.float    "speed"
    t.integer  "crew"
    t.string   "diesel"
    t.string   "sternthrusters"
    t.string   "stabilizers"
    t.string   "winch"
    t.string   "hook"
    t.float    "cablelength"
    t.integer  "cranes"
    t.float    "craneloading"
    t.integer  "sails"
    t.float    "sailsarea"
    t.string   "location"
    t.decimal  "price",                 :precision => 10, :scale => 2
    t.string   "info"
    t.integer  "position"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.text     "object"
    t.date     "construction_end_date"
    t.decimal  "price_end",             :precision => 10, :scale => 0
    t.integer  "water"
    t.integer  "fuelname_id"
  end

  create_table "refinery_user_plugins", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "position"
  end

  add_index "refinery_user_plugins", ["name"], :name => "index_refinery_user_plugins_on_name"
  add_index "refinery_user_plugins", ["user_id", "name"], :name => "index_refinery_user_plugins_on_user_id_and_name", :unique => true

  create_table "refinery_users", :force => true do |t|
    t.string   "username",               :null => false
    t.string   "email",                  :null => false
    t.string   "encrypted_password",     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count"
    t.datetime "remember_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "slug"
  end

  add_index "refinery_users", ["id"], :name => "index_refinery_users_on_id"
  add_index "refinery_users", ["slug"], :name => "index_refinery_users_on_slug"

  create_table "registrations", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "registrs", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "searches", :force => true do |t|
    t.integer  "status_id"
    t.integer  "category_id"
    t.integer  "area_id"
    t.integer  "currency_id"
    t.integer  "power_id"
    t.string   "title"
    t.string   "flag"
    t.string   "project"
    t.date     "first_date"
    t.date     "last_date"
    t.string   "first_length"
    t.string   "last_length"
    t.string   "first_max_draught"
    t.string   "last_max_draught"
    t.string   "first_deadweight"
    t.string   "last_deadweight"
    t.string   "first_price"
    t.string   "last_price"
    t.string   "first_power"
    t.string   "last_power"
    t.string   "first_passengers"
    t.string   "last_passengers"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "info"
  end

  create_table "seo_meta", :force => true do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type"
    t.string   "browser_title"
    t.text     "meta_description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "seo_meta", ["id"], :name => "index_seo_meta_on_id"
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], :name => "id_type_index_on_seo_meta"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "ship_docs", :force => true do |t|
    t.integer  "attachment_id"
    t.string   "doc_file_name"
    t.string   "doc_content_type"
    t.integer  "doc_file_size"
    t.datetime "doc_updated_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "ship_files", :force => true do |t|
    t.integer  "attachment_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "ship_photos", :force => true do |t|
    t.integer  "attachment_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "speednames", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "statuss", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

  create_table "vats", :force => true do |t|
    t.string "rutitle"
    t.string "entitle"
  end

end
