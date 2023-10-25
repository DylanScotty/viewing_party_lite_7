class UsersController < ApplicationController 
  def index 
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @viewing_parties = @user.invited_viewing_parties
    @movie_id = (params[:movie_id])
    @facade = MoviesDetailsFacade.new(@movie_id)
      begin
        @user = User.find(params[:id])
        raise "Please log in or register" unless logged_in?
        @facade = MovieDetailsFacade.new
      rescue StandardError => e
        redirect_to root_path
        flash[:error] = e.message
      end
  end

  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      flash[:success] = "New User created successfully."
      redirect_to user_path(@user)
    else 
      flash[:error] = "Registration failed: " + @user.errors.full_messages.join(', ')
      redirect_to register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end