class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if admin_user?
      @users = User.all
    else
      redirect_to login_path
    end
  end

  def show
    if @user == current_user || admin_user?

    else
      redirect_to root_path
    end
  end

  def new
    @user = User.new(:password => "")
  end

  def edit
    if @user == current_user || admin_user?

    else
      redirect_to users_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #session[:user_id] = @user.id
      redirect_to root_path
    else
      @errors = @user.errors
      render 'new'
    end
  end

  def update
    if admin_user?
      if @user = User.update(user_params)
        redirect_to root_path
      else
        @errors = @user.errors
        render 'edit'
      end
    elsif @user == current_user
      if @user = User.update(player_user_params)
        redirect_to root_path
      else
        @errors = @user.errors
        render 'edit'
      end
    end
  end

  def destroy
    if logged_in?
      if admin_user?
        @user.destroy

        redirect_to '/'
      else
        redirect_to '/'
      end
    else
      redirect_to login_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email,:name,:password,:user_type)
    end

    def player_user_params
      new_params = user_params
      new_params[:user_type] = :player
      new_params
    end
end
