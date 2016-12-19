class BooksController < ApplicationController
  before_action :logged_in_user
  before_action :load_book, only: :show
  
  def index
    @book_search = Book.by_author_or_title(params[:search])
      .by_category params[:category]
    @books = @book_search.order_created_at.paginate page: params[:page],
      per_page: Settings.book.per_page
    @categories = Category.all
  end

  def show
    @mark = Mark.find_by user_id: current_user.id, book_id: params[:id]
    unless @mark 
      @mark= Mark.new user_id: current_user.id, book_id: params[:id]
      @mark.save
    end
  end

  private 
  def load_book
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:danger] = t "controller.book.flash.fail"
      redirect_to books_url 
    end
    @reviews = @book.reviews.created_desc
      .paginate page: params[:page], per_page: Settings.book.per_page
    @review = Review.new
  end
end
