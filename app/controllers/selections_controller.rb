class SelectionsController < ApplicationController

  def new
    @selection = Selection.new
    @book = Book.new
  end

  def create
    @selection = Selection.new params[:selection]
    @selection.save 
    redirect_to selection_books_path
  end


  def show
    @selection = Selection.find params[:id]
    @books = @selection.books
  end 
end