class OmniauthCallbacksController < ApplicationController

	def twitter
		user  = User.twitter_auth request.env["omniauth.auth"]
		sign_in_and_redirect user
		flash[:notice] = "Signed in successfully."
	end

	# def failure
	# 	raise 'fuck'
	# end
end
