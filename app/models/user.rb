class User < ActiveRecord::Base

  has_one :selection
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable 

  def self.twitter_auth auth
  	credentials = { uid: auth[:uid], provider: :twitter }
  	pwd = Devise.friendly_token[0,20]

  	User.find_or_create_by(credentials) do |user|
    	user.name = auth[:info][:nickname]
    	user.password = pwd
    	user.password_confirmation = pwd
    	user.avatar_url = auth[:info][:image]
    end
 end

 def from_twitter?
  provider == 'twitter'
end

 def email_required?
 	return false if from_twitter?
 	super
 end

def password_required?
  return false if from_twitter?
  super
end

end
