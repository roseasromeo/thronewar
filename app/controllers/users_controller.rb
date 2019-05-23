class UsersController < ApplicationController

  def new
    @user = User.new(:password => "")
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to rules_pages_path
    else
      @errors = @user.errors
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email,:name,:password)
    end

end
