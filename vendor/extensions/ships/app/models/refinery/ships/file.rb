module Refinery
  module Ships
    class File < Refinery::Core::BaseModel
      self.table_name = 'ship_files'
      attr_accessible										:file, :attachment_id

      has_attached_file									:file

      belongs_to												:attachment, :class_name=>'Refinery::Ships::Attachment', :dependent => :destroy
			
			validates_attachment_content_type	:photo, :content_type => /\Aimage\/.*\Z/

    end
  end
end
