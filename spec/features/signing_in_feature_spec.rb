require 'spec_helper'

describe "user sign up" do 

	context 'New user' do

	it "should ba able to sign up" do
		visit 'users/sign_up'
		fill_in 'Email', with: 'tom@t.com'
		fill_in 'Password', with: '12345678'
		fill_in 'Password confirmation', with: '12345678'
		click_button 'Sign up'
		expect(current_path).to eq'/' 
		expect(page).to have_content "Welcome! You have signed up successfully."
	end
end

	# context 'already registered user' do 

	# it "should be able to login in" do 
	# 	visit 'users/sign_in'
	# 	fill_in 'Email', with: 'tom@t.com'
	# 	fill_in 'Password', with: '12345678'
	# 	click_button 'Sign in'
	# 	expect(current_path).to eq'/'

	# end

	# end
end