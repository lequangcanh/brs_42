class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.order_by_created_at_desc.paginate page: params[:page], 
      per_page: Settings.category.per_page
  end
  
  def edit
  end
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".created"
      redirect_to admin_categories_path
    else
      flash.now[:danger] = t ".create_error"
      render :new
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".updated"
      redirect_to admin_categories_path
    else
      flash.now[:danger] = t ".update_error"
      render :edit
    end
  end

  def destroy
    if @category.books.any?
      flash[:danger] = t ".relationship_error"
    elsif @category.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".delete_error"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t ".not_found"
      redirect_to :back
    end
  end
end
