class FinalCharactersController < ApplicationController
  include Rules
  include Characteristics
  include AspectsActions

  before_action :set_final_character, only: [:show, :edit, :update, :wishes]
  before_action :setup
  before_action :editable

  helper_method :html_safe_rescue, :ranks_collection, :aspect_level, :gift_level

  def show
    @flaw1 = (@final_character.flaw1 != nil ? Flaw.find(@final_character.flaw1.id) : nil)
    @flaw2 = (@final_character.flaw2 != nil ? Flaw.find(@final_character.flaw2.id) : nil)
    @ranks = @final_character.ranks.order(:item)

    @buy_up_total = 0
    @ranks.each do |rank|
      @buy_up_total = @buy_up_total + (rank.public_rank - rank.private_rank)
      if rank.item == "illusion"
        if rank.private_rank > 0
          @illusion = true
        else
          @illusion = false
        end
      end
    end
    @talent = talent(@final_character)
    @fate = fate_count(@final_character)
    @wishes_count = wish_count(@final_character)
    @wisps_count = wisp_count(@final_character)
    @forms_count = form_count(@final_character)
    @need_wishes = need_wishes?(@final_character)

    if @buy_up_total > @talent
      @talent_violation = true
    else
      @talent_violation = false
    end
    if @editable || @character_system.complete?
      @show_all = true
      if @final_character.submitting?
        @final_character.not_submitted!
        # fix issue if there is a Big error on submission
      end
    else
      @show_all = false
    end
  end

  def edit
    @character_user = @final_character.user
    available_users = User.includes(:final_characters).where(:final_characters => {:user_id => nil}).or(User.includes(:final_characters).merge(FinalCharacter.where.not(character_system: @character_system))) #fix this
    @possible_users = available_users.or(User.where(id: @character_user.id).includes(:final_characters)).distinct

    @flaw1_id = @final_character.flaw1 == nil ? nil : @final_character.flaw1.id
    @flaw2_id = @final_character.flaw2 == nil ? nil : @final_character.flaw2.id

    gutter_rank = @final_character.ranks.where(item: Rank.items[:gutter_magic]).first
    @need_wishes = need_wishes?(@final_character)

    if @editable
      @ranks = @final_character.ranks.order(:item)
      @ranks.each do |rank|
        puts rank.item
      end
    else
      redirect_to character_system_final_character_path(@character_system, @final_character)
    end
  end

  def update
    if params[:commit] == 'Save Wishes'
      save_wishes
    else
      @flaw1_id = @final_character.flaw1 == nil ? nil : @final_character.flaw1.id
      @flaw2_id = @final_character.flaw2 == nil ? nil : @final_character.flaw2.id
      @need_wishes = need_wishes?(@final_character)

      if @editable
        @user = User.find(final_character_params[:user_id])
        flaw1_id = final_character_params[:flaw1]
        if flaw1_id != "" && flaw1_id != nil
          @flaw1 = Flaw.find(flaw1_id)
        else
          @flaw1 = nil
        end
        flaw2_id = final_character_params[:flaw2]
        if flaw2_id != "" && flaw2_id != nil
          @flaw2 = Flaw.find(flaw2_id)
        else
          @flaw2 = nil
        end

        if @final_character.update(character_system: @character_system, user: @user, name: final_character_params[:name], blurb: final_character_params[:blurb], background: final_character_params[:background], backstory_connections: final_character_params[:backstory_connections], goal: final_character_params[:goal], curses: final_character_params[:curses], extra_wishes: final_character_params[:extra_wishes], other: final_character_params[:other], luck: final_character_params[:luck], flaw1: @flaw1, flaw2: @flaw2) #
          @final_character.ranks.each do |rank|
            item_number = Rank.items[rank.item]
            if final_character_params[:ranks_attributes][item_number.to_s].has_key?("private_rank")
              rank.private_rank = final_character_params[:ranks_attributes][item_number.to_s]["private_rank"]
              rank.save
            end
          end
          @final_character.save
          redirect_to [@character_system, @final_character]
        else
          render 'edit'
        end
      else
        redirect_to character_system_final_character_path(@character_system, @final_character)
      end
    end
  end

  def submit
    @final_character = FinalCharacter.find(params[:final_character_id])
    @final_character.submitting!
    @character_system = @final_character.character_system
    error = check_valid(@final_character)
    if error == false
      @final_character.submitted!
    else
      @final_character.not_submitted!
    end
    redirect_to character_system_final_character_path(@character_system, @final_character)
  end

  def approve
    if gm_user?
      @final_character = FinalCharacter.find(params[:final_character_id])
      @character_system = @final_character.character_system
      @final_character.approved!
    end
    redirect_to character_system_final_character_path(@character_system, @final_character)
  end

  def reject
    if gm_user?
      @final_character = FinalCharacter.find(params[:final_character_id])
      @character_system = @final_character.character_system
      @final_character.not_submitted!
    end
    redirect_to character_system_final_character_path(@character_system, @final_character)
  end

  def wishes
    if @editable
      @wishes = @final_character.wishes
      @final_character_wishes = @final_character.final_character_wishes
      @all_wishes = @character_system.wishes
    else
      redirect_to character_system_final_character_path(@character_system, @final_character)
    end
  end

  def save_wishes
    if @editable
      wishes_params[:final_character_wishes_attributes].each do |k,v|
        if v["_destroy"] == "false"
          if @final_character.final_character_wishes.where(wish: Wish.find(v[:wish_id])).empty?
            wish = @final_character.final_character_wishes.new(final_character: @final_character, wish: Wish.find(v[:wish_id]))
            wish.save
          end
        else
          destroy_id = v["id"].to_i
          wish = FinalCharacterWish.find(destroy_id).destroy
        end
      end
      redirect_to character_system_final_character_path(@character_system, @final_character)
    else
      redirect_to character_system_final_character_path(@character_system, @final_character)
    end
  end

  private
    def final_character_params
      params.require(:final_character).permit(:user_id, :flaw1, :flaw2, :name, :blurb, :background, :backstory_connections, :goal, :curses, :wishes, :extra_wishes, :other, :luck, :leftover_points, ranks_attributes: [:id, :private_rank])
    end

    def wishes_params
      params.require(:final_character).permit(final_character_wishes_attributes: [:wish_id, :final_character_id, :_destroy, :id])
    end

    def html_safe_rescue(text)
      text_return = text.html_safe
    rescue NoMethodError
      text_return = ""
    end

    def ranks_collection(ranks, all_ranks)
      collection = Hash.new
      ranks.each do |rank|
        collection[rank.item] = []
        rank_number = rank.public_rank
        collection[rank.item] << ["Rank: #{rank_number} Points: #{rank.public_points}, +0", rank_number]
        while rank_number > 1
          item = rank.item
          rank_number = rank_number - 1
          new_rank = all_ranks.where(public_rank: rank_number, item: Rank.items[item]).first
          points_change = new_rank.public_points - rank.public_points
          new_rank_number = rank_number + 0.5
          collection[rank.item] << ["Rank: #{new_rank_number} Points: #{new_rank.public_points}, +#{points_change}", rank_number]
        end
      end
      collection
    end

    def setup
      set_character_system
      set_user
    end

    def set_final_character
      if params[:final_character_id] != nil
        @final_character = FinalCharacter.find(params[:final_character_id])
      else
        @final_character = FinalCharacter.find(params[:id])
      end
    end

    def set_character_system
      @character_system = @final_character.character_system
    end

    def set_user
      @user = current_user
    end

    def editable
      @editable = (@final_character.user == @user && @final_character.not_submitted?) || gm_user?
    end

end
