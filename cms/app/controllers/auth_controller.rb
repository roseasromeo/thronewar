class AuthController < ApplicationController

  def new
    render :login
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to rules_pages_path
    end
  end

  def login
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to rules_pages_path
    else
      flash[:alert] = "You entered in the wrong email or password"
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to login_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
