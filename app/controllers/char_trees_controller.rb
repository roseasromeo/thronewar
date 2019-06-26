class CharTreesController < ApplicationController
  include Rules
  before_action :set_char_tree, only: [:show, :edit, :update, :destroy]

  # No Index

  # GET /char_trees/1
  # GET /char_trees/1.json
  def show
    if logged_in?
      @user = current_user
      @character_system = CharacterSystem.find(params[:character_system_id])
      @final_character = @char_tree.final_character
      @ability_count_messages = ability_count_messages(@final_character)
    else
      redirect_to login_path
    end
  end

  # GET /char_trees/new
  def new
    @final_character = FinalCharacter.find(params[:final_character])
    @character_system = CharacterSystem.find(params[:character_system_id])
    @ability_count_messages = ability_count_messages(@final_character)
    if CharTree.where(final_character: @final_character).empty?
      @user = current_user

      if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
        @char_tree = CharTree.new(final_character: @final_character)
      else
        redirect_to [@character_system, @final_character]
      end
    else
      redirect_to [@character_system, @final_character]
    end
  end

  # GET /char_trees/1/edit
  def edit
    @user = current_user
    @char_tree = CharTree.find(params[:id])
    @final_character = @char_tree.final_character
    @character_system = CharacterSystem.find(params[:character_system_id])
    @ability_count_messages = ability_count_messages(@final_character)

    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      # edit
    else
      redirect_to [@character_system, @final_character]
    end
  end

  # POST /char_trees
  # POST /char_trees.json
  def create
    @final_character = FinalCharacter.find(char_tree_params[:final_character_id])
    @character_system = CharacterSystem.find(params[:character_system_id])
    @ability_count_messages = ability_count_messages(@final_character)

    if CharTree.where(final_character: @final_character).empty?
      @char_tree = CharTree.new(char_tree_params)

      if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
        if @char_tree.save
          redirect_to [@character_system, @char_tree]
        else
          if @char_tree.ability_char_tree_cleanup
            redirect_to [@character_system, @final_character], notice: "The ability tree for this character included an ability they do not have access to and has now been deleted"
          else
            render 'new'
          end
        end
      else
        redirect_to [@character_system, @final_character]
      end
    else
      redirect_to [@character_system, @final_character]
    end
  end

  # PATCH/PUT /char_trees/1
  # PATCH/PUT /char_trees/1.json
  def update
    @final_character = FinalCharacter.find(char_tree_params[:final_character_id])
    @character_system = CharacterSystem.find(params[:character_system_id])
    @ability_count_messages = ability_count_messages(@final_character)

    if !(CharTree.where(final_character: @final_character).empty?)
      cleaned_params = char_tree_params.to_h
      cleaned_params["ability_char_trees_attributes"].each do |k,v|
        if v["_destroy"] != "false"
          destroy_id = v["id"].to_i
          AbilityCharTree.find(destroy_id).destroy
          cleaned_params["ability_char_trees_attributes"] = cleaned_params["ability_char_trees_attributes"].except(k)
        end
      end
      if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
        if @char_tree.update(cleaned_params)
          redirect_to [@character_system, @char_tree]
        else
          if @char_tree.ability_char_tree_cleanup
            redirect_to [@character_system, @final_character], notice: "The ability tree for this character included an ability they do not have access to and has now been deleted"
          else
            render 'new'
          end
        end
      else
        redirect_to [@character_system, @final_character]
      end
    else
      redirect_to [@character_system, @final_character]
    end
  end

  # DELETE /char_trees/1
  # DELETE /char_trees/1.json
  def destroy
    if logged_in?
      @char_tree.destroy
      respond_to do |format|
        format.html { redirect_to char_trees_url, notice: 'Char tree was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_char_tree
      @char_tree = CharTree.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def char_tree_params
      params.require(:char_tree).permit(:final_character_id, ability_char_trees_attributes: [:id, :char_tree_id, :ability_id, :_destroy])
    end

    def ability_count_hash(final_character)
      count_hash = Hash.new
      gifts = [ :command, :change, :illusion, :gutter_magic ]
      ranks = final_character.ranks
      gifts.each do |gift|
        private_rank = ranks.where(item: Rank.items[gift]).first.private_rank
        lowest_rank = final_character.character_system.ranks.where(item: Rank.items[gift]).maximum(:public_rank)
        basic_num = basic_abilities(private_rank, lowest_rank)
        int_num = int_abilities(private_rank, lowest_rank)
        adv_num = adv_abilities(private_rank, lowest_rank)
        count_hash[gift] = {:basic => basic_num, :intermediate => int_num, :advanced => adv_num}
      end
      count_hash
    end

    def ability_count_messages(final_character)
      count_hash = ability_count_hash(final_character)
      gifts = [ :command, :change, :illusion, :gutter_magic ]
      levels = [ :basic, :intermediate, :advanced ]
      messages = []
      gifts.each do |gift|
        levels.each do |level|
          if count_hash[gift][level].to_i > 0
            new_message = "This character may have #{count_hash[gift][level]} #{level} abilities for #{gift.to_s.titlecase} at their current #{gift.to_s.titlecase} Rank."
            messages.push(new_message)
          end
        end
      end
      messages
    end
end
