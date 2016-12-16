class RatesController < ApplicationController
  before_action :logged_in_user, only: [:create, :update]
  before_action :find_rate, only: :update

  def create
    @rate = current_user.rates.build rate_params
    if @rate.save
      update_book
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = @rate.errors.full_messages
      redirect_to root_url
    end
  end

  def update
    if @rate.update_attributes rate_params
      update_book
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = @rate.errors.full_messages
      redirect_to root_url
    end
  end

  private
  def rate_params
    params.require(:rate).permit :number_rates, :book_id, :user_id
  end

  def find_rate
    @rate = current_user.rates.find_by id: params[:id]
    unless @rate
      flash[:danger] = t "controllers.flash.rate_not_found"
      redirect_to root_url
    end
  end

  def update_book
    @rate.book.update_attributes avg_rate: Rate.average_for_book(@rate.book.id).round(1)
  end
end
