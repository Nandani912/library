class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :only_allow_owners, only: [:new, :create, :edit, :update, :destroy]

  def index
    if user_signed_in? && current_user.customer?
     @books=Book.all
     @q = Book.ransack( params[:q])
     @books = @q.result(distinct: true)
     
    else
     @books = current_user.books
    end  
  end
  def show
   @book=Book.find(params[:id])
  end
  def new
    @book=Book.new
  end
    def create
    @book=current_user.books.build(book_params)
    if @book.save
      redirect_to @book
     else
      render 'new'
     end
    end
  def edit
    @book=Book.find(params[:id])
  end
  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)  
      redirect_to @book
    else
      render 'edit'
    end
    end
      def destroy
       @book=Book.find(params[:id])
       @book.destroy
     redirect_to books_path
      end

  private
  def book_params       
    params.require(:book).permit(:title,:author,:price,:description)
  end


  def only_allow_owners
    unless current_user.owner?
      redirect_to books_path, alert: "You are not authorized to perform this action."
    end
  end
end