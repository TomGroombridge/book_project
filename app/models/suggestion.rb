class Suggestion < ActiveRecord::Base

  require 'csv'
  # path = "/Users/larahy/Desktop/Cabbage/scripts/scriptsinplanning/small.csv"
  
  # def self.add_books_from(path)
  #   titles = CSVImport.new.compile(path)

  #   titles.compact.map do |details|
  #     Suggestion.create(details)
  #   end
  # end



  def self.run_csv_import
    index = 0
    CSV.foreach("/Users/larahy/Desktop/Cabbage/scripts/scriptsinplanning/content.csv") do |book|
      begin
        if book[11] == 'English'
          self.create(title: book[1], author: book[5], isbn: book[15].gsub('-', '').to_i)
        end
        index += 1
        puts index if (index % 1000).zero?
      rescue CSV::MalformedCSVError
        next
      end
    end
  end

end
