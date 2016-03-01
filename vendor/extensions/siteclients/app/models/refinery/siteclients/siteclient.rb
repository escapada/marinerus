module Refinery
  module Siteclients
    class Siteclient < Refinery::Core::BaseModel
      self.table_name = 'refinery_clients'

			has_many :ships, :class_name => 'Refinery::Ships::Ship'
			has_many :attachments, :class_name => 'Refinery::Ships::Attachment'

      acts_as_indexed :fields => [:name]

			attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :company, :job, :phone, :mail_me, :position

      devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:email]

      validates :email, :presence => true, :uniqueness => true
    end
  end
end
