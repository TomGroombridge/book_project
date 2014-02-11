class OmniauthCallbacksController < ApplicationController

	def twitter
		user = User.twitter_auth request.env["omniauth.auth"]
		sign_in user
    redirect_to "/users/#{current_user.name}"
	end
	
end
