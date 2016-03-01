# This migration comes from refinery_siteclients (originally 1)
class CreateSiteclientsSiteclients < ActiveRecord::Migration

  def change
    add_column :refinery_clients, :position, :integer
  end

end
