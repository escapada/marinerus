module Refinery
  module Ships
    class File < Refinery::Core::BaseModel
      self.table_name = 'ship_files'
      attr_accessible     :file, :attachment_id

      has_attached_file :file

      belongs_to  :attachment, :class_name=>'Refinery::Ships::Attachment'

      do_not_validate_attachment_file_type :file

      #validates_attachment :file, :presence => true,
      #                                  content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

    end
  end
end
