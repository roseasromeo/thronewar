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

  helper_method :current_user, :admin_user?, :gm_user?, :logged_in?, :strikes, :flash_messages

  private
    def get_auction
      @characters = @game.characters
      @auctions = @game.auctions

      get_aspect_auction
      get_gift_auction

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
        @aspect_closed = @aspect_auction.closed?
      else
        @last_aspect_round = nil
        @last_aspect_pledges = nil
        @aspect_closed = false
      end
    end

    def get_gift_auction
      @gift_auction = @auctions.gift.first
      @gift_exists = (@gift_auction != nil)
      if @gift_exists
        @current_gift_round = @gift_auction.rounds.order(number: :desc).first
        if @current_gift_round.number != 1
          @last_gift_round = @gift_auction.rounds.order(number: :desc).second
          @last_gift_pledges = @last_gift_round.pledges
        else
          @last_gift_round = nil
          @last_gift_pledges = nil
        end
        @gift_items = @gift_auction.items
        @gift_closed = @gift_auction.closed?
      else
        @last_gift_round = nil
        @last_gift_pledges = nil
        @gift_closed = false
      end
    end

    def get_current_round
      if @aspect_exists && !@aspect_closed
        @items = @aspect_items
        @current_round = @current_aspect_round
        @last_round = @last_aspect_round
        @auction = @aspect_auction
        @aspect_pledges_to_display = @last_aspect_pledges
        @gift_pledges_to_display = nil
      elsif @gift_exists && !@gift_closed
        @items = @gift_items
        @current_round = @current_gift_round
        @last_round = @last_gift_round
        @auction = @gift_auction
        if @current_aspect_round.pledges.empty?
          @aspect_pledges_to_display = @last_aspect_round.pledges
        else
          @aspect_pledges_to_display = @current_aspect_round.pledges
        end
        @gift_pledges_to_display = @last_gift_pledges
      elsif @aspect_closed && @gift_closed
        @items = nil
        @current_round = nil
        @last_round = nil
        @auction = nil
        if @current_aspect_round.pledges.empty?
          @aspect_pledges_to_display = @last_aspect_round.pledges
        else
          @aspect_pledges_to_display = @current_aspect_round.pledges
        end
        if @current_gift_round.pledges.empty?
          @gift_pledges_to_display = @last_gift_round.pledges
        else
          @gift_pledges_to_display = @current_gift_round.pledges
        end
      elsif @aspect_closed && !@gift_exists
        @items = nil
        @current_round = nil
        @last_round = nil
        @auction = nil
        if @current_aspect_round.pledges.empty?
          @aspect_pledges_to_display = @last_aspect_round.pledges
        else
          @aspect_pledges_to_display = @current_aspect_round.pledges
        end
        @gift_pledges_to_display = nil
      else
        @items = nil
        @current_round = nil
        @last_round = nil
        @auction = nil
        @aspect_pledges_to_display = nil
        @gift_pledges_to_display = nil
      end
    end

    def all_items_closed?
      if @current_round.number != 1
        items = @last_round.items
        all_closed = true
        items.each do |item|
          all_closed = all_closed && item.closed?
        end
      else
        all_closed = false
      end
      all_closed
    end

    def strikes(num_strikes)
      if num_strikes == 0
        string = '0'
      else
        string = ''
      end
      num_strikes.times do
        string << 'X'
      end
      string
    end

    def flash_messages
      flash[:error].full_messages
    rescue NoMethodError
      ["Error message problem. Inform your Arbiter."]
    end
end
