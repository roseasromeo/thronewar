class CharTreesController < ApplicationController
  before_action :set_char_tree, only: [:show, :edit, :update, :destroy]

  # GET /char_trees
  # GET /char_trees.json
  def index
    @char_trees = CharTree.all
  end

  # GET /char_trees/1
  # GET /char_trees/1.json
  def show
  end

  # GET /char_trees/new
  def new
    @char_tree = CharTree.new
  end

  # GET /char_trees/1/edit
  def edit
  end

  # POST /char_trees
  # POST /char_trees.json
  def create
    @char_tree = CharTree.new(char_tree_params)

    respond_to do |format|
      if @char_tree.save
        format.html { redirect_to @char_tree, notice: 'Char tree was successfully created.' }
        format.json { render :show, status: :created, location: @char_tree }
      else
        format.html { render :new }
        format.json { render json: @char_tree.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /char_trees/1
  # PATCH/PUT /char_trees/1.json
  def update
    respond_to do |format|
      if @char_tree.update(char_tree_params)
        format.html { redirect_to @char_tree, notice: 'Char tree was successfully updated.' }
        format.json { render :show, status: :ok, location: @char_tree }
      else
        format.html { render :edit }
        format.json { render json: @char_tree.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /char_trees/1
  # DELETE /char_trees/1.json
  def destroy
    @char_tree.destroy
    respond_to do |format|
      format.html { redirect_to char_trees_url, notice: 'Char tree was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_char_tree
      @char_tree = CharTree.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def char_tree_params
      params.require(:char_tree).permit(:final_character_id)
    end
end
