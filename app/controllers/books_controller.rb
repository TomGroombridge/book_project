class BooksController < ApplicationController

	def new
		@book = Book.new
	end

	def create
		params[:book]
		@books = Book.find_top_matches(params[:book][:title])
		# @book.user = current_user
		# @book.save
		redirect_to books_path
	end

	def git 
		@books = Book.all
	end

end
