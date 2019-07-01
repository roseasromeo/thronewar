class FlawsController < ApplicationController

  before_action :set_flaw, only: [:destroy]
  before_action :set_character_system

  def index
    @flaws = Flaw.where(character_system: @character_system)
  end

  def new
    if gm_user?
      @flaw = @character_system.flaws.new
    else
      redirect_to character_system_flaws_path(@character_system)
    end
  end

  def create
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

    def set_flaw
      @flaw = Flaw.find(params[:id])
    end

    def set_character_system
      @character_system = CharacterSystem.find(params[:character_system_id])
    end

end
