class WishesController < ApplicationController

  before_action :set_wish, only: [:destroy]
  before_action :set_character_system

  def index
    @wishes = Wish.where(character_system: @character_system)
  end

  def new
    if gm_user?
      @wish = @character_system.wishes.new
    else
      redirect_to character_system_wishes_path(@character_system)
    end
  end

  def create
    if gm_user?
      @wish = @character_system.wishes.new(wish_params)
      if @wish.save
        redirect_to character_system_wishes_path(@character_system)
      else
        render 'new'
      end
    else
      redirect_to character_system_wishes_path(@character_system)
    end
  end

  def destroy
    if gm_user?
      @wish.destroy
      redirect_to character_system_wishes_path(@character_system)
    else
      redirect_to character_system_wishes_path(@character_system)
    end
  end

  private
    def wish_params
      params.require(:wish).permit(:name, :description, :link)
    end

    def set_wish
      @wish = Wish.find(params[:id])
    end

    def set_character_system
      @character_system = CharacterSystem.find(params[:character_system_id])
    end

end
