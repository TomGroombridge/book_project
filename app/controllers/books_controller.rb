class BooksController < ApplicationController

	def create
		@books = Book.find_top_matches(params[:book][:title])
		# @book.user = current_user
		# @book.save
		render json: @books.to_json
	end
	
end
