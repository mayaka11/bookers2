class BooksController < ApplicationController
before_action :is_matching_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "Book detail successfully"
     redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user

  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
    flash[:destroy] = "successfully delete"
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:booksuccess] = "Editing Book successfully"
      redirect_to book_path(@book.id)
    else
      flash[:Failed] = "error"
      render :edit
    end
  end

 private

  def book_params
    params.require(:book).permit(:title, :body, :user_id, :profile_image)
  end

  def is_matching_user
    book = Book.find(params[:id])
    user_id = book.user.id
    unless user_id == current_user.id
      redirect_to books_path
    end
  end


end
