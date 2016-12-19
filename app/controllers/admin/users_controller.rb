class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: [:destroy, :update]

  def index
    @users = User.order_desc.paginate page: params[:page],
      per_page: Settings.user.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.users.destroy.deleted"
    else
      flash[:danger] = t "admin.users.destroy.error"
    end
    redirect_to admin_users_url
  end

  def update
    if params[:role] == Settings.role.admin
      @user.is_admin = true
    else
      @user.is_admin = false
    end

    if @user.save
      flash[:success] = t("admin.users.update.updated", role: params[:role])
    else
      flash[:danger] = t "admin.users.update.error"
    end
    redirect_to :back
  end
  
  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "admin.users.destroy.not_found"
      redirect_to :back
    end
  end
end
