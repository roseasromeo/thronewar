class FlawsController < ApplicationController

  def index
    @character_system = CharacterSystem.find(params[:character_system_id])
    @flaws = Flaw.where(character_system: @character_system)
  end

  def new
    @character_system = CharacterSystem.find(params[:character_system_id])
    if gm_user?
      @flaw = @character_system.flaws.new
    else
      redirect_to character_system_flaws_path(@character_system)
    end
  end

  def create
    @character_system = CharacterSystem.find(params[:character_system_id])
    if gm_user?
      @flaw = @character_system.flaws.new(flaw_params)
      if @flaw.save
        redirect_to character_system_flaws_path(@character_system)
      else
        render 'new'
      end
    else
      redirect_to character_system_flaws_path(@character_system)
    end
  end

  def destroy
    @character_system = CharacterSystem.find(params[:character_system_id])
    @flaw = Flaw.find(params[:id])
    if gm_user?
      @flaw.destroy
      redirect_to character_system_flaws_path(@character_system)
    else
      redirect_to character_system_flaws_path(@character_system)
    end
  end

  private
    def flaw_params
      params.require(:flaw).permit(:name, :description, :link)
    end

end
