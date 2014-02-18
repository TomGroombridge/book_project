require 'spec_helper'

describe 'creating a book' do 

it "should have content when a book is inputed" do
	visit "/"
	fill_in "Enter your title with dog eared pages", with: 'Harry Potter'
	click_button "Submit"
	expect(page).to have_content
end




end