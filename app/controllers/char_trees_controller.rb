class CharTreesController < ApplicationController
  include Rules
  before_action :set_char_tree, only: [:show, :edit, :update, :destroy]
  before_action :setup
  before_action :editable

  # No Index

  # GET /char_trees/1
  # GET /char_trees/1.json
  def show
    if logged_in?

    else
      redirect_to login_path
    end
  end

  # GET /char_trees/new
  def new
    if CharTree.where(final_character: @final_character).empty?
      @user = current_user

      if @editable
        @char_tree = CharTree.new(final_character: @final_character)
      else
        redirect_to [@character_system, @final_character]
      end
    else
      @char_tree = CharTree.where(final_character: @final_character).first
      redirect_to [@character_system, @char_tree]
    end
  end

  # GET /char_trees/1/edit
  def edit
    if @editable
      # edit
    else
      redirect_to [@character_system, @final_character]
    end
  end

  # POST /char_trees
  # POST /char_trees.json
  def create
    if CharTree.where(final_character: @final_character).empty?
      @char_tree = CharTree.new(char_tree_params)

      if @editable
        if @char_tree.save
          redirect_to [@character_system, @char_tree]
        else
          if @char_tree.ability_char_tree_cleanup
            flash_message :notice, "The ability tree for this character included an ability they do not have access to and has now been deleted"
            redirect_to [@character_system, @final_character]
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
    if @editable && !(CharTree.where(final_character: @final_character).empty?)
      cleaned_params = char_tree_params.to_h
      cleaned_params["ability_char_trees_attributes"].each do |k,v|
        if v["_destroy"] != "false"
          destroy_id = v["id"].to_i
          AbilityCharTree.find(destroy_id).destroy
          cleaned_params["ability_char_trees_attributes"] = cleaned_params["ability_char_trees_attributes"].except(k)
        end
      end
      if @editable
        if @char_tree.update(cleaned_params)
          redirect_to [@character_system, @char_tree]
        else
          if @char_tree.ability_char_tree_cleanup
            flash_message :notice, "The ability tree for this character included an ability they do not have access to and has now been deleted"
            redirect_to [@character_system, @final_character]
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
    if @editable
      @char_tree.destroy
      redirect_to [@character_system]
    else
      redirect_to [@character_system]
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_char_tree
      @char_tree = CharTree.find(params[:id])
    end

    def setup
      set_final_character
      set_character_system
      set_user
      @ability_count_messages = ability_count_messages(@final_character)
    end

    def set_final_character
      if @char_tree != nil
        @final_character = @char_tree.final_character
      elsif params[:final_character] != nil
        @final_character = FinalCharacter.find(params[:final_character])
      else
        @final_character = FinalCharacter.find(char_tree_params[:final_character_id])
      end
    end

    def editable
      @editable = (@final_character.user == @user && @final_character.not_submitted?) || gm_user?
    end

    def set_user
      @user = current_user
    end

    def set_character_system
      @character_system = CharacterSystem.find(params[:character_system_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def char_tree_params
      params.require(:char_tree).permit(:final_character_id, ability_char_trees_attributes: [:id, :char_tree_id, :ability_id, :_destroy])
    end

end
