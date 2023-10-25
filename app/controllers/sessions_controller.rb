class SessionsController < ApplicationController
    def new
    end

    def create
      begin
        user = User.find_by_email(params[:email])
        raise "Invalid credentials. Please Try again." unless user && user.authenticate(params[:password])
        session[:user_id] = user.id
        login(user) 
        redirect_to user_path(user)
        flash[:success_login] = "Welcome back, #{user.name}"
      rescue StandardError => e
        redirect_to login_path
        flash[:error] = e.message
      end
    end
  
    def destroy
      log_out 
      redirect_to root_path
    end
end