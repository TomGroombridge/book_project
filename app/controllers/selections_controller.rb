class SelectionsController < ApplicationController

  def new
    @selection = Selection.new
    @book = Book.new
  end

  def create
    @selection = Selection.new params[:selection].permit(book_ids: [])
    @selection.user = current_user
    @selection.save
    # redirect_to selection_path @selection
        redirect_to "/users/#{current_user.name}"
  end


  def show
    @selection = Selection.find params[:id]
    @books = @selection.books
    @top_books = Book.top_10_books
  end 


  def showuser
    user = User.find_by(:name => params[:username])
    @selection = Selection.find_by(:user_id => user.id)
    @books = @selection.books
    @top_books = Book.top_10_books
    render 'show'
  end 

end
