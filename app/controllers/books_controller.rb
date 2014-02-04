class BooksController < ApplicationController

	def new
		@book = Book.new
	end

	def create
		params[:book]
		@book = Book.new(params[:book].permit(:title))
		# @book.user = current_user
		@book.save
		redirect_to books_path
	end

	def index
		@books = Book.all
	end

end
