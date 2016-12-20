class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user_follow, only: :create
  before_action :load_user_unfollow, only: :destroy

  def index
    @user = User.find_by id: params[:user_id]
    relationship = params[:relationship]
    if relationship == "following"
      @title = t ".following_title"
      @users = @user.following
        .paginate page: params[:page], per_page: Settings.users.per_page
    else
      @title = t ".followers_title"
      @users = @user.followers
        .paginate page: params[:page], per_page: Settings.users.per_page
    end
    set_relationship @user
  end

  def create
    if current_user.follow @user
      @relationship = current_user.active_relationships.find_by followed_id: @user.id
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".fail_follow"
      redirect_to @user
    end
  end

  def destroy
    if current_user.unfollow @user
      @relationship = current_user.active_relationships.build
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".fail_unfollow"
      redirect_to @user
    end
  end

  private
  def load_user_follow
    @user = User.find_by id: params[:followed_id]
    unless @user
      flash[:danger] = t "relationships.not_found_relationship"
      redirect_to root_url
    end
  end

  def load_user_unfollow
    relation = Relationship.find_by id: params[:id]
    if relation
      @user = relation.followed
    else
      flash[:danger] = t "relationships.not_found_relationship"
      redirect_to root_url
    end
  end
end
