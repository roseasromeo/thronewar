class FinalCharactersController < ApplicationController
  include Rules

  helper_method :html_safe_rescue, :ranks_collection, :aspect_level, :gift_level

  def show
    @final_character = FinalCharacter.find(params[:id])
    @user = current_user
    @character_system = @final_character.character_system
    @flaw1 = (@final_character.flaw1 != nil ? Flaw.find(@final_character.flaw1.id) : nil)
    @flaw2 = (@final_character.flaw2 != nil ? Flaw.find(@final_character.flaw2.id) : nil)
    @buy_up_total = 0
    @final_character.ranks.each do |rank|
      @buy_up_total = @buy_up_total + (rank.public_rank - rank.private_rank)
      if rank.item == "ego"
        @ego_rank = rank.private_rank
      end
    end
    @talent = talent(@ego_rank, @character_system.ranks.where(item: Rank.items[:ego]).maximum(:public_rank))
    if @buy_up_total > @talent
      @talent_violation = true
    else
      @talent_violation = false
    end
    if gm_user? || @final_character.user == @user || @character_system.complete?
      @show_all = true
    else
      @show_all = false
    end
  end

  def edit
    @final_character = FinalCharacter.find(params[:id])
    @user = current_user
    @character_system = @final_character.character_system
    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      # edit
    else
      redirect_to character_system_final_character_path(@character_system, @final_character)
    end
  end

  def update
    @user = current_user
    @final_character = FinalCharacter.find(params[:id])
    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      @character_system = CharacterSystem.find(params[:character_system_id])
      @user = User.find(final_character_params[:user_id])
      leftover_points = 0
      flaw1_id = final_character_params[:flaw1_id]
      if flaw1_id != ""
        @flaw1 = Flaw.find(flaw1_id)
      else
        @flaw1 = nil
      end
      flaw2_id = final_character_params[:flaw2_id]
      if flaw2_id != ""
        @flaw2 = Flaw.find(flaw2_id)
        puts @flaw2
      else
        @flaw2 = nil
      end
      if @final_character.update(character_system: @character_system, user: @user, name: final_character_params[:name], blurb: final_character_params[:blurb], background: final_character_params[:background], backstory_connections: final_character_params[:backstory_connections], goal: final_character_params[:goal], curses: final_character_params[:curses], standardform: final_character_params[:standardform], other: final_character_params[:other], luck: final_character_params[:luck], leftover_points: leftover_points, flaw1: @flaw1, flaw2: @flaw2)
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

  def submit
    @final_character = FinalCharacter.find(params[:final_character_id])
    @character_system = @final_character.character_system
    notices = approval(@final_character)
    if false && (notices.empty? || notices == nil)
      @final_character.submitted!
    else
      flash[:notice] = notices
    end
    redirect_to character_system_final_character_path(@character_system, @final_character)
  end

  def approve
    redirect_to character_system_final_character_path(@character_system, @final_character)
  end

  def reject
    redirect_to character_system_final_character_path(@character_system, @final_character)
  end

  private
    def final_character_params
      params.require(:final_character).permit(:user_id, :flaw1_id, :flaw2_id, :name, :blurb, :background, :backstory_connections, :goal, :curses, :standardform, :other, :luck, :leftover_points, ranks_attributes: [:id, :private_rank])
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

end