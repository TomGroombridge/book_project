class SelectionsController < ApplicationController

  def new
    @selection = Selection.new
    @book = Book.new
  end

  def create
    # params[:selection][:book_ids] = ['3', '5', '7']

    @selection = Selection.new params[:selection].permit(book_ids: [])
    @selection.save
    redirect_to '/'
  end


  def show
    @selection = Selection.find params[:id]
    @books = @selection.books
  end 
end
