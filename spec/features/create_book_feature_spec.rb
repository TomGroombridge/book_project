require 'spec_helper'

describe ' creating a book' do 


	# context 'given a title, author, image, url and category' do

	# 	it "should display the title of the book" do 
	# 		visit 'books/new'
	# 		fill_in 'Title', with: 'Mr Tickle'
	# 		click_button 'Submit'
	# 		expect(current_path).to eq '/books'
	# 		expect(page).to have_content 'Mr Tickle'
	# 	end	

	it "should not redirect the page when submitted" do 
		visit '/'
		click_button 'Submit'
		expect(current_path).to eq '/'

	end




end