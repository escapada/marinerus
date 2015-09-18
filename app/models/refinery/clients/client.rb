#require 'active_record'
require 'devise'

module Refinery
  module Clients
    class Client < Refinery::Core::BaseModel
      self.table_name = 'refinery_clients'

      has_many :ships, :class_name => 'Refinery::Ships::Ship'
      has_many :attachments, :class_name => 'Refinery::Ships::Attachment'

      acts_as_indexed :fields => [:name]

     # validates :email, :presence => true, :uniqueness => true

      #devise methods
      # Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
      #attr_accessor :login
      devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:email]

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :company, :job, :phone, :mail_me

    end
  end
end
