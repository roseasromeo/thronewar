class PledgesController < ApplicationController
  def create
    if logged_in?
      @pledge = Pledge.new(pledge_params)
=begin
  # Not sure what goes here, some kind of save?
      if @pledge.save
        redirect_to @character
      else
        render 'new'
      end
=end
    else
      redirect_to login_path
    end
  end

  def destroy
    if logged_in?
      if gm_user?
        @pledge = Pledge.find(params[:id])
        @pledge.destroy

        redirect_to '/'
      else
        redirect_to '/'
      end
    else
      redirect_to login_path
    end
  end

  def pledge_params
    params.require(:pledge).permit(:user, :game, :pseudonym, :points_spent)
  end
end
