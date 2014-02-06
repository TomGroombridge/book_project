 class Book < ActiveRecord::Base
  has_and_belongs_to_many :selections
  # before_create :get_stuff



  # def top10_books
  #   @book.selection.length 
  #   @book.selection.sort_by {|book| book.length }
  # end 

  def self.find_top_matches(title)
    books = AmazonBookFetcher.new.search(title)

    books.map do |book_details|
      preexisting_book = find_by(asin: book_details['asin'])

      preexisting_book ? preexisting_book : Book.create(book_details)
    end
  end


 
  # def get_stuff
  #   book_details = AmazonBookFetcher.new.search(title)

  #     book_details.each do |key, value|
  #       self[key] = value
  #      end
  #   end

end
