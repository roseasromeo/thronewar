class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Helpful authentication methods
  def current_user
    @_current_user ||=User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  def admin_user?
    if logged_in?
      current_user.admin?
    else
      false
    end
  end

  def gm_user?
    if logged_in?
      current_user.admin? || current_user.gm?
    else
      false
    end
  end

  helper_method :current_user, :admin_user?, :gm_user?, :logged_in?

  private
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

    def get_current_round
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
    end
end
