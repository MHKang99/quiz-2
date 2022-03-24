class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        like = Like.new
        idea = Idea.find params[:idea_id]
        like.idea = idea
        like.user = current_user
        if like.save
            flash[:notice] = "thank you for the like"
            redirect_to idea_path(idea.id)
        else 
            p "did not save like or already liked"
            redirect_to idea_path(idea.id)
        end

    end

    def destroy
        idea = Idea.find params[:idea_id]
        like = current_user.likes.find params[:id]
        if like.destroy
            flash[:notice] = "Unliked"
            redirect_to idea_path(idea.id)
        else
            p "could not unlike"
        end
    end
end
