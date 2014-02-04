 class Book < ActiveRecord::Base
    before_create :get_stuff
 
  def get_stuff
    book_details = AmazonBookFetcher.new.search(title)

    book_details.each do |key, value|
        self[key] = value
       end
    end

  end
