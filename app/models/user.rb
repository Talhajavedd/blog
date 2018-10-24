class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  has_and_belongs_to_many :roles
  has_many :articles
  accepts_nested_attributes_for :roles 
  validates :email, uniqueness: true
  validate :validate_username
  validates :username, presence: :true, uniqueness: { case_sensitive: false } 
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
	def validate_username
  		if User.where(email: username).exists?
    		errors.add(:username, :invalid)
  		end
	end

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def roles_attributes=(attributes)
  	keys = []
  	attributes.keys.each do |k|
  		keys << attributes[k]["id"]
  	end
  	if keys.length > 0
  		self.roles = Role.where(id: keys)
  	end
  end

 def self.find_first_by_auth_conditions(warden_conditions)
  	conditions = warden_conditions.dup
  	conditions = warden_conditions.dup
  	conditions[:email].downcase! if conditions[:email]
  	if login = conditions.delete(:login)
    	where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  	else
    	if conditions[:username].nil?
      		where(conditions).first
    	else
      		where(username: conditions[:username]).first
    	end
  	end
  end

end
