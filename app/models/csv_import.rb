require 'csv'
# require_relative 'suggestion'

# class CSVImport

# #   path = "/Users/larahy/Desktop/Cabbage/scripts/scriptsinplanning/small.csv"
#   def compile("/Users/larahy/Desktop/Cabbage/scripts/scriptsinplanning/small.csv")
    CSV.foreach("/Users/larahy/Desktop/Cabbage/scripts/scriptsinplanning/small.csv") do |book|
      if book[11] == 'English'
      # Suggestion.create(title: book[1], author: book[5], isbn: book[15].gsub('-', ''))
        p book[1] + book[5] + book[15]
      end
    end


