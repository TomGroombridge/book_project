# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'csv'

Rails.application.load_tasks

task :autocomplete_import => :environment do
  
  CSV.open("/Users/larahy/Desktop/Cabbage/scripts/scriptsinplanning/content.csv"){|csv|
    book, index = true, 0
    while book
      begin
        book = csv.shift
        index += 1

        break unless book
        if book[11] == 'English'
          Suggestion.create(title: book[1].truncate(250), author: book[5].truncate(250), isbn: book[15].gsub('-', '').truncate(250))
        end

        puts index if (index % 1000).zero?
      rescue CSV::MalformedCSVError => e
        next
      end
    end
  }

  # CSV.foreach("/Users/larahy/Desktop/Cabbage/scripts/scriptsinplanning/content.csv") do |book|
  # index += 1
  # puts index if (index % 1000).zero?
  # end
end