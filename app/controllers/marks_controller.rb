class MarksController < ApplicationController
  before_action :logged_in_user, except: [:destroy, :edit]
  before_action :load_mark, only: :update

  def new
    @mark = Mark.new
  end

  def create
    @mark = Mark.new mark_params
    unless @mark.save
      flash[:danger] = t "marks.create.error"
      render :new
    end
  end
 
  def update
    if params[:favorite]
      @mark.is_favorite = params[:favorite]
      @mark.save
      respond_to do |format|
        format.html
        format.js
      end
    end

    if params[:mark_type]
      @mark.mark_type = params[:mark_type]
      @mark.save
    end
    redirect_to :back
  end

  private
  def load_mark
    @mark = Mark.find_by id: params[:id]
    unless @mark
      flash[:danger] = t "marks.update.not_found"
      redirect_to :back
    end
  end
end
