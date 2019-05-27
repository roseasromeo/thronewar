class AbilityDependenciesController < ApplicationController
  before_action :set_ability_dependency, only: [:show, :edit, :update, :destroy]

  # GET /ability_dependencies
  # GET /ability_dependencies.json
  def index
    @ability_dependencies = AbilityDependency.all
  end

  # GET /ability_dependencies/1
  # GET /ability_dependencies/1.json
  def show
  end

  # GET /ability_dependencies/new
  def new
    @ability_dependency = AbilityDependency.new
  end

  # GET /ability_dependencies/1/edit
  def edit
  end

  # POST /ability_dependencies
  # POST /ability_dependencies.json
  def create
    @ability_dependency = AbilityDependency.new(ability_dependency_params)

    respond_to do |format|
      if @ability_dependency.save
        format.html { redirect_to @ability_dependency, notice: 'Ability dependency was successfully created.' }
        format.json { render :show, status: :created, location: @ability_dependency }
      else
        format.html { render :new }
        format.json { render json: @ability_dependency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ability_dependencies/1
  # PATCH/PUT /ability_dependencies/1.json
  def update
    respond_to do |format|
      if @ability_dependency.update(ability_dependency_params)
        format.html { redirect_to @ability_dependency, notice: 'Ability dependency was successfully updated.' }
        format.json { render :show, status: :ok, location: @ability_dependency }
      else
        format.html { render :edit }
        format.json { render json: @ability_dependency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ability_dependencies/1
  # DELETE /ability_dependencies/1.json
  def destroy
    @ability_dependency.destroy
    respond_to do |format|
      format.html { redirect_to ability_dependencies_url, notice: 'Ability dependency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ability_dependency
      @ability_dependency = AbilityDependency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ability_dependency_params
      params.require(:ability_dependency).permit(:parent_id, :depends_on_id)
    end
end
