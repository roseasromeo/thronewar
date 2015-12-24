class CharRoundsController < ApplicationController
  def new
    @user = current_user
    @game = Game.find(params[:game_id])
    if @game.preparing?
      redirect_to game_path(@game)
    else
      @character = @game.characters.where(user: @user).first

      get_auction
      get_current_round

      if @items != nil
        @char_round = CharRound.new(round: @current_round, character: @character)
        @items.count.times do
          @char_round.pledges.build
        end
      end
    end
  end

  def create
    @game = Game.find(params[:game_id])
    @user = current_user
    @character = @game.characters.where(user: @user).first
    get_auction
    get_current_round
    if CharRound.where(character: @character, round: @current_round).empty?
      @char_round = CharRound.new(character: @character, round: @current_round)
      if @char_round.save
        @item_counter = 1
        @items.each do |item|
          @item_counter = @item_counter + 1
        end
          render 'new'
          #redirect_to player_game_path(@game)
      else
        render 'new'
      end
    else
      @char_round = CharRound.where(character: @character, round: @current_round)
      render 'new'
      #redirect_to player_game_path(@game), :error => "Pledges for this round already submitted. Please wait."
    end
  end

  def destroy

  end

  private
    def char_rounds_params
      params.require(:char_round).permit(:character, :round, pledges_attributes: [:id, :value, :_destroy])
    end
end
