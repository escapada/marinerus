module Refinery
  module Ships
    class Attachment < Refinery::Core::BaseModel
    	self.table_name = 'attachments'
      attr_accessible	:client_id, :ship_id

      belongs_to			:ship, :class_name=>'Refinery::Ships::Ship'
      belongs_to			:client, :class_name=>'Refinery::Clients::Client'

      has_many				:photos, :class_name => 'Refinery::Ships::Photo'
      has_many				:docs, :class_name => 'Refinery::Ships::Doc'

    end
  end
end
