class Admin::BooksController < Admin::BaseController
  before_action :load_book, except: [:index, :new, :create]
  before_action :load_categories, except: [:show, :destroy]
  
  def index
    @books = Book.order_created_at.paginate page: params[:page],
      per_page: Settings.book.per_page
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "admin.books.create.created"
      redirect_to admin_books_path
    else
      flash.now[:danger] = t "admin.books.create.create_error"
      render :new
    end
  end
  
  def edit
  end
  
  def show
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "admin.books.update.updated"
      redirect_to admin_books_path
    else
      flash.now[:danger] = t "admin.books.update.update_error"
      render :edit
    end
  end

  def destroy
    if @book.reviews.any?
      flash[:danger] = t "admin.books.destroy.relationship_error"
    elsif @book.destroy
      flash[:success] = t "admin.books.destroy.deleted"
    else
      flash[:danger] = t "admin.books.destroy.delete_error"
    end
    redirect_to admin_books_path
  end

  private
  def book_params
    params.require(:book).permit :title, :category_id, :description,
      :publish_date, :author, :number_of_pages, :image
  end

  def load_book
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:danger] = t "admin.books.load_data.not_found"
      redirect_to admin_books_path
    end
  end
  
  def load_categories
    @categories = Category.all
  end
end
