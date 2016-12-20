module LikesHelper
  def create_like review
    if review.is_liked_by? current_user
      @destroy_like = review.likes.find_by user_id: current_user.id
      unless @destroy_like
        redirect_to root_url
        flash[:danger] = t "controllers.flash.like_not_found"
      end
      review.likes.find_by user_id: current_user.id
    else
      likes_path review_id: review.id
    end
  end
end
