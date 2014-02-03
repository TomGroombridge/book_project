require 'spec_helper'

describe ' creating a book' do 


	context 'given a title, author, image, url and category' do

		it "should display the title of the book" do 
			visit 'books/new'
			fill_in 'Title', with: 'Mr Tickle'
			click_button 'Submit'
			expect(current_path).to eq '/books'
			expect(page).to have_content 'Mr Tickle'
		end	

		it "should display the author of the book" do 
			visit 'books/new'
			fill_in 'Author', with: 'Rodge Hargreaves'
			click_button 'Submit'
			expect(current_path).to eq '/books'
			expect(page).to have_content 'Rodge Hargreaves'
	end

		it "should display the Image of the book" do 
			visit 'books/new'
			fill_in 'Image', with: 'orange man with long arms'
			click_button 'Submit'
			expect(current_path).to eq '/books'
			expect(page).to have_content 'orange man with long arms'
		end

		it "should display the Url of the book" do 
			visit 'books/new'
			fill_in 'Url', with: 'amazon.com'
			click_button 'Submit'
			expect(current_path).to eq '/books'
			expect(page).to have_content 'amazon.com'
			
		end

		it "should display Category of the book" do 
			visit 'books/new'
			fill_in 'Category', with: 'Kids'
			click_button 'Submit'
			expect(current_path).to eq '/books'
			expect(page).to have_content 'Kids'
		end
	end


end