class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.find_by(email: user_params[:email])
        p user_params
        
        if @user && @user.authenticate(user_params[:password])
            p @user
            flash[:notice] = "Logged In"
            cookies[:user_id] = @user.id
            redirect_to root_path
        else 
            p @user
            flash[:notice] = "Invalid email or password"
            redirect_to session_new_path
        end
    end

    def destroy
        cookies[:user_id] = nil
        flash.notice = "Logged out"
        redirect_to root_path
    end
    
    private

    def user_params
        params.require(:user).permit(:name, :email, :password)
    end
end
