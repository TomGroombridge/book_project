class OmniauthCallbacksController < ApplicationController

	def twitter
		user = User.twitter_auth request.env["omniauth.auth"]
		sign_in user
    flash[:notice] = "Signed in successfully."
    redirect_to '/'
	end

	# def failure
	# 	raise 'fuck'
	# end
end
