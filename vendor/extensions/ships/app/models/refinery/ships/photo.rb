module Refinery
  module Ships
    class Photo < Refinery::Core::BaseModel
      self.table_name = 'ship_photos'
      attr_accessible										:photo, :attachment_id

      has_attached_file									:photo, styles: {thumbnail: "60x60#"}

      belongs_to												:attachment, :class_name=>'Refinery::Ships::Attachment', :dependent => :destroy
			
			validates_attachment_content_type	:photo, :content_type => /\Aimage\/.*\Z/

    end
  end
end
