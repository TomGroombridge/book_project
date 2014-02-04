require 'spec_helper'

  describe 'adding attributes using amazon api' do

    context 'given a book title' do
      it 'should know the author' do
        visit 'books/new'
        fill_in 'Title', with: 'Mr Tickle'
        click_button 'Submit'
        expect(current_path).to eq '/books'
        expect(page).to have_content 'Roger Hargreaves'
      end
    end
    
  end

