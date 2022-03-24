class IdeasController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :update]
  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new params.require(:idea).permit(:title, :body)

    if @idea.save
      redirect_to root_path
    else
      p "didnt save"
    end
  end

  def show
    @idea = Idea.find params[:id]
    @username = User.find_by_id @idea.user_id
    @review = Review.new
    @reviews = Review.where idea_id: @idea.id
    if user_signed_in?
      @likes = Like.where(idea_id: @idea.id, user_id: current_user.id).first
    end
  end

  def index
    @idea = Idea.all.order(id: :desc)
    p @idea[0]
    render status: 202
  end

  def destroy
    @idea = Idea.find params[:id]
    author = User.find_by_id @idea.user_id
    if current_user == author
      @idea.destroy
      redirect_to root_path
    end
  end

  def edit
    @idea = Idea.find params[:id]
  end

  def update
    @idea = Idea.find params[:id]
    author = User.find_by_id @idea.user_id

    if current_user == author
      if @idea.update params.require(:idea).permit(:title, :body)
          redirect_to idea_path(@idea.id)
      else 
          redirect_to edit_idea_path
      end
    else
      flash[:alert] = "not authroized to make changes" 
      redirect_to edit_idea_path
    end
  end
end
