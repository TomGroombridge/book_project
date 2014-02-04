class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable 

  def self.twitter_auth auth
  	credentials = { uid: auth[:uid], provider: :twitter }
  	pwd = Devise.friendly_token[0,20]

  	new_user = find_or_create_by(credentials) do |user|
    	user.name = auth[:info][:name]
    	user.password = pwd
    	user.password_confirmation = pwd
    	user.avatar_url = auth[:info][:image]
    end
    new_user.save
    new_user
 end

 def email_required?
 	return false if provider == 'twitter'
 	super
 end

end
