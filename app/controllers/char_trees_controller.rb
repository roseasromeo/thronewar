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
    else
      redirect_to login_path
    end
  end

  # GET /char_trees/new
  def new
    @final_character = FinalCharacter.find(params[:final_character])
    @character_system = CharacterSystem.find(params[:character_system_id])
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
    if CharTree.where(final_character: @final_character).empty?
      @char_tree = CharTree.new(char_tree_params)

      if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
        if @char_tree.save
          redirect_to [@character_system, @char_tree]
        else
          render 'new'
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
    if !(CharTree.where(final_character: @final_character).empty?)
      if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
        if @char_tree.update(char_tree_params)
          redirect_to [@character_system, @char_tree]
        else
          render 'new'
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
end
