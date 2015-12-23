class GamesController < ApplicationController
  def index
    if logged_in?
      @games = Game.all
    else
      redirect_to login_path
    end
  end

  def show
    if logged_in?
      @user = current_user
      @game = Game.find(params[:id])
      @new_character = @game.characters.where(user: @user).empty?
    else
      redirect_to login_path
    end
  end

  def new
    if gm_user?
      @game = Game.new
    else
      redirect_to '/'
    end
  end


  def create
    if logged_in?
      if gm_user?
        @game = Game.new(game_params)

        if @game.save
          redirect_to @game
        else
          render 'new'
        end
      else
        redirect_to '/'
      end
    else
      redirect_to login_path
    end
  end

  def start
    @game = Game.find(params[:id])
    if gm_user? && @game.preparing?
      @game.started!
      redirect_to gm_game_path(@game)
    else
      redirect_to game_path(@game)
    end
  end

  def gm
    if gm_user?
      @game = Game.find(params[:id])
      if @game.preparing?
        redirect_to game_path(@game)
      else
        get_auction
      end
    else
      redirect_to '/'
    end
  end

  def player
    @game = Game.find(params[:id])
    if @game.preparing?
      redirect_to game_path(@game)
    else
      @character = @game.characters.where(user: @user).first
      get_auction
      if @aspect_exists && !@aspect_closed
        @items = @aspect_items
        @current_round = @current_aspect_round
      elsif @gift_exists && !@gift_closed
        @items = @gift_items
        @current_round = @current_gift_round
      else
        @items = nil
        @current_round = nil
      end
      if @items != nil
        @pledges = []
        @items.each do |item|
          @pledges << Pledge.new(character: @character, round: @current_round, item: item, value: 0)
        end
      end
    end
  end

  def aspect
    @game = Game.find(params[:id])
    @auction = Auction.new(game: @game, phase: :aspect)
    if @auction.save
      # Create the round
      @round = Round.new(auction: @auction, number: 1)
      if !(@round.save)
        @errors = @round.save.errors
      end
      # Create the Aspect Items
      @battle = Item.new(auction: @auction, name: :battle)
      if !(@battle.save)
        @errors = @errors + @battle.save.errors
      end
      @cunning = Item.new(auction: @auction, name: :cunning)
      if !(@cunning.save)
        @errors.add(@battle.save.errors)
      end
      @destiny = Item.new(auction: @auction, name: :destiny)
      if !(@destiny.save)
        @errors.add(@battle.save.errors)
      end
      @ego = Item.new(auction: @auction, name: :ego)
      if !(@ego.save)
        @errors.add(@battle.save.errors)
      end
      @flesh = Item.new(auction: @auction, name: :flesh)
      if !(@flesh.save)
        @errors.add(@errors + @battle.save.errors)
      end
      redirect_to gm_game_path, :flash => { :error => @errors }
    else
      redirect_to '/' #this is just wrong
    end
  end

  private
    def game_params
      params.require(:game).permit(:title)
    end

    def get_auction
      @characters = @game.characters
      @auctions = @game.auctions

      get_aspect_auction

      @gift_auction = @auctions.gift.first
      @gift_exists = (@gift_auction != nil)

      if @gift_exists
        @last_gift_round = @gift_auction.rounds.order_by(number: :desc).first
        @last_gift_pledges = @last_gift_round.pledges
        @gift_closed = @gift_auction.closed?
      else
        @last_gift_round = nil
        @last_gift_pledges = nil
        @gift_closed = nil
      end
    end

    def get_aspect_auction
      @aspect_auction = @auctions.aspect.first
      @aspect_exists = (@aspect_auction != nil)
      if @aspect_exists
        @current_aspect_round = @aspect_auction.rounds.order(number: :desc).first
        if @current_aspect_round.number != 1
          @last_aspect_round = @aspect_auction.rounds.order(number: :desc).second
          @last_aspect_pledges = @last_aspect_round.pledges
        else
          @last_aspect_round = nil
          @last_aspect_pledges = nil
        end
        @aspect_items = @aspect_auction.items

        #@battle = @items.battle.first
        #@cunning = @items.cunning.first
        #@destiny = @items.destiny.first
        #@ego = @items.ego.first
        #@flesh = @items.flesh.first

        @aspect_closed = @aspect_auction.closed?
      else
        @last_aspect_round = nil
        @last_aspect_pledges = nil
        @aspect_closed = false
      end
    end
end
