class OmniauthCallbacksController < ApplicationController

	def twitter
		user = User.twitter_auth request.env["omniauth.auth"]
		sign_in user
		user.selection = Selection.find session[:selection_id]
    redirect_to "/users/#{current_user.name}"
	end
	
end
