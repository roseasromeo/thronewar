class AbilityCharTreesController < ApplicationController
  before_action :set_ability_char_tree, only: [:show, :edit, :update, :destroy]

  # GET /ability_char_trees
  # GET /ability_char_trees.json
  def index
    @ability_char_trees = AbilityCharTree.all
  end

  # GET /ability_char_trees/1
  # GET /ability_char_trees/1.json
  def show
  end

  # GET /ability_char_trees/new
  def new
    @ability_char_tree = AbilityCharTree.new
  end

  # GET /ability_char_trees/1/edit
  def edit
  end

  # POST /ability_char_trees
  # POST /ability_char_trees.json
  def create
    @ability_char_tree = AbilityCharTree.new(ability_char_tree_params)

    respond_to do |format|
      if @ability_char_tree.save
        format.html { redirect_to @ability_char_tree, notice: 'Ability char tree was successfully created.' }
        format.json { render :show, status: :created, location: @ability_char_tree }
      else
        format.html { render :new }
        format.json { render json: @ability_char_tree.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ability_char_trees/1
  # PATCH/PUT /ability_char_trees/1.json
  def update
    respond_to do |format|
      if @ability_char_tree.update(ability_char_tree_params)
        format.html { redirect_to @ability_char_tree, notice: 'Ability char tree was successfully updated.' }
        format.json { render :show, status: :ok, location: @ability_char_tree }
      else
        format.html { render :edit }
        format.json { render json: @ability_char_tree.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ability_char_trees/1
  # DELETE /ability_char_trees/1.json
  def destroy
    @ability_char_tree.destroy
    respond_to do |format|
      format.html { redirect_to ability_char_trees_url, notice: 'Ability char tree was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ability_char_tree
      @ability_char_tree = AbilityCharTree.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ability_char_tree_params
      params.require(:ability_char_tree).permit(:char_tree_id, :ability_id)
    end
end
