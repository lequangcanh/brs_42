class UsersController < ApplicationController
  before_action :logged_in_user, only: :edit
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = t "welcome_message"
    else
      render :new
    end
  end
  
  def update
    if @user.update_attributes name: params[:user][:name]
      flash[:success] = t ".success_update"
      redirect_to @user
    else
      render :edit
    end
  end

  def show
    @user = User.find_by id: params[:id]
    return render file: Settings.page_404_url unless @user
    set_relationship @user
    @favorite_books = @user.list_favorite_books
      .paginate page: params[:favorite_book_page], per_page: Settings.book.per_page
    @histories = User.marks.not_unread.order_updated_at
      .paginate page: params[:page], per_page: Settings.mark.per_page
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]
    render file: Settings.page_404_url unless current_user.is_user? @user
  end
end
