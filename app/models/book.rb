 class Book < ActiveRecord::Base
  has_and_belongs_to_many :selections
  # before_create :get_stuff

  def self.find_top_matches(title)
    books = AmazonBookFetcher.new.search(title)

    books.compact.map do |book_details|
      preexisting_book = find_by(asin: book_details['asin'])

      puts book_details.inspect
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
