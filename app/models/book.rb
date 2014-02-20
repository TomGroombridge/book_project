class Book < ActiveRecord::Base
  has_and_belongs_to_many :selections
  scope :top_ten, -> { where('ranking IS NOT NULL').order(:ranking) }
  # before_create :get_stuff

  

  def self.find_top_matches(title)
    books = AmazonBookFetcher.new.search(title)
    return { error: "No book found" } if !books
    # if books.exist?

      books.compact.map do |book_details|
        preexisting_book = find_by(asin: book_details['asin'])

        preexisting_book ? preexisting_book : Book.create(book_details)
      end
  end

  # def self.top_10_books
  #   hello = find_by_sql("select book_id, count(*) total from books_selections group by book_id having count(*) > 1 order by count(*) desc limit 10")
  #   puts "wakka wakka"
  #   puts hello.inspect
  #   hello
  # end

  # def self.top_10_books
  #   top_ten = all.sort_by { |book| -book.selections.length }.first(10)
  # end

 
  # def get_stuff
  #   book_details = AmazonBookFetcher.new.search(title)

  #     book_details.each do |key, value|
  #       self[key] = value
  #      end
  #   end

end
