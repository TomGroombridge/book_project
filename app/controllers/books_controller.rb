class BooksController < ApplicationController

	def new
		@book = Book.new
	end

	def create
		params[:book]
		book = Book.new(params[:book].permit(:title, :author, :image, :url, :category))
		book.save
		redirect_to books_path
	end

	def index
		@books = Book.all
	end

end
