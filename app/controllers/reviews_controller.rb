class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_idea

    def create
        @idea = Idea.find params[:idea_id]
        @review = Review.new params.require(:review).permit(:title, :body)
        @review.user_id = cookies[:user_id]
        @review.idea_id = @idea.id
        if @review.save
            puts "saved"
            redirect_to idea_path(@idea.id)
        else
            puts 'did not save'
            redirect_to idea_path(@idea.id)
        end
    end

    def destroy
        p cookies[:user_id]
        @review = Review.find params[:id]
        p @review.user_id
        if @review.user_id == cookies[:user_id].to_i 
            @review.destroy
            p "destroyed"
            redirect_to idea_path(@idea.id)
        else
            p "could not destory"
        end
    end

    private

    def find_idea
        @idea = Idea.find params[:idea_id]
    end
end
