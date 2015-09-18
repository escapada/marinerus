class AddConfirmFieldsToClient < ActiveRecord::Migration
  def change
	add_column :refinery_clients, :confirmation_token, :string
	add_column :refinery_clients, :confirmed_at, :datetime
	add_column :refinery_clients, :confirmation_sent_at, :datetime
	# add_column :refinery_clients, :unconfirmed_email, :string  # Only if using reconfirmable
	# it means every email change should be confirmed evry time. not using. 

	add_index :refinery_clients, :confirmation_token,   :unique => true
  end
end