class UsersController < ApplicationController 
  def index 
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @viewing_parties = @user.invited_viewing_parties
    @movie_id = (params[:movie_id])
    @facade = MoviesDetailsFacade.new(@movie_id)
  end

  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "New User created successfully."
      redirect_to user_path(@user)
    else 
      flash[:error] = "Registration failed: " + @user.errors.full_messages.join(', ')
      redirect_to register_path
    end
  end

  def login_form

  end

  def login_user
    begin
      user = User.find_by(email: params[:email])
      raise "Invalid credentials. Please Try again." unless user && user.authenticate(params[:password])
      redirect_to user_path(user)
    rescue StandardError => e
      redirect_to login_path
      flash[:error] = e.message
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end