class AbilityFunctionsController < ApplicationController
  before_action :set_ability_function, only: [:show, :edit, :update, :destroy]
  before_action :check_admin

  # GET /ability_functions
  # GET /ability_functions.json
  def index
    @ability_functions = AbilityFunction.all
  end

  # GET /ability_functions/1
  # GET /ability_functions/1.json
  def show
  end

  # GET /ability_functions/new
  def new
    @ability_function = AbilityFunction.new
  end

  # GET /ability_functions/1/edit
  def edit
  end

  # POST /ability_functions
  # POST /ability_functions.json
  def create
    @ability_function = AbilityFunction.new(ability_function_params)

    respond_to do |format|
      if @ability_function.save
        format.html { redirect_to @ability_function, notice: 'Ability function was successfully created.' }
        format.json { render :show, status: :created, location: @ability_function }
      else
        format.html { render :new }
        format.json { render json: @ability_function.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ability_functions/1
  # PATCH/PUT /ability_functions/1.json
  def update
    respond_to do |format|
      if @ability_function.update(ability_function_params)
        format.html { redirect_to @ability_function, notice: 'Ability function was successfully updated.' }
        format.json { render :show, status: :ok, location: @ability_function }
      else
        format.html { render :edit }
        format.json { render json: @ability_function.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ability_functions/1
  # DELETE /ability_functions/1.json
  def destroy
    @ability_function.destroy
    respond_to do |format|
      format.html { redirect_to ability_functions_url, notice: 'Ability function was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ability_function
      @ability_function = AbilityFunction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ability_function_params
      params.require(:ability_function).permit(:name, :operation)
    end

    def check_admin
      if !admin_user?
        redirect_to root_path
      end
    end
end
