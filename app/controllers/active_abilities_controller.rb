class ActiveAbilitiesController < ApplicationController
  before_action :set_active_ability, only: [:show, :edit, :update, :destroy]

  # GET /active_abilities
  # GET /active_abilities.json
  def index
    @active_abilities = ActiveAbility.all
  end

  # GET /active_abilities/1
  # GET /active_abilities/1.json
  def show
  end

  # GET /active_abilities/new
  def new
    @active_ability = ActiveAbility.new
  end

  # GET /active_abilities/1/edit
  def edit
    # I think I want to remove the edit action
  end

  # POST /active_abilities
  # POST /active_abilities.json
  def create
    @active_ability = ActiveAbility.new(active_ability_params)
    # Create prompts for rounds
    respond_to do |format|
      if @active_ability.save
        format.html { redirect_to active_ability_prompts_path[@active_ability], notice: 'Active ability was successfully created.' }
        # format.json { render :show, status: :created, location: @active_ability }
      else
        format.html { render :new }
        format.json { render json: @active_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /active_abilities/1
  # PATCH/PUT /active_abilities/1.json
  def update

    # respond_to do |format|
    #   if @active_ability.update(active_ability_params)
    #     format.html { redirect_to @active_ability, notice: 'Active ability was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @active_ability }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @active_ability.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /active_abilities/1
  # DELETE /active_abilities/1.json
  def destroy
    @active_ability.destroy
    respond_to do |format|
      format.html { redirect_to active_abilities_url, notice: 'Active ability was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_active_ability
      @active_ability = ActiveAbility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def active_ability_params
      params.require(:active_ability).permit(:name, :game_ability_id, prompt_values_attributes: [:id, :value])
    end
end
