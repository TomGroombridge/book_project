class OmniauthCallbacksController < ApplicationController

	def twitter
		user = User.twitter_auth request.env["omniauth.auth"]
		user.selection = Selection.find session[:selection_id]
    sign_in_and_redirect(user) and return
	end
	
end
