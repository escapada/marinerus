module Refinery
  module Ships
    class Doc < Refinery::Core::BaseModel
      self.table_name = 'ship_docs'
      attr_accessible :doc, :attachment_id

      has_attached_file :doc

      belongs_to  :attachment, :class_name=>'Refinery::Ships::Attachment'

      do_not_validate_attachment_file_type :doc

    end
  end
end
