class GameAbilitiesController < ApplicationController
  before_action :set_game_ability, only: [:show, :edit, :update, :destroy]

  # GET /game_abilities
  # GET /game_abilities.json
  def index
    @game_abilities = GameAbility.all
  end

  # GET /game_abilities/1
  # GET /game_abilities/1.json
  def show
  end

  # GET /game_abilities/new
  def new
    if gm_user?
      @game_ability = GameAbility.new
    else
      redirect_to game_abilities_path
    end
  end

  # GET /game_abilities/1/edit
  def edit
    if gm_user?
    else
      redirect_to game_ability_path[@game_ability]
    end
  end

  # POST /game_abilities
  # POST /game_abilities.json
  def create
    if gm_user?
      @game_ability = GameAbility.new(game_ability_params)

      respond_to do |format|
        if @game_ability.save
          format.html { redirect_to @game_ability, notice: 'Game Ability was successfully created.' }
          format.json { render :show, status: :created, location: @game_ability }
        else
          format.html { render :new }
          format.json { render json: @game_ability.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to game_abilities_path
    end
  end

  # PATCH/PUT /game_abilities/1
  # PATCH/PUT /game_abilities/1.json
  def update
    if gm_user?
      respond_to do |format|
        if @game_ability.update(game_ability_params)
          format.html { redirect_to @game_ability, notice: 'Game Ability was successfully updated.' }
          format.json { render :show, status: :ok, location: @game_ability }
        else
          format.html { render :edit }
          format.json { render json: @game_ability.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to game_ability_path[@game_ability]
    end
  end

  # DELETE /game_abilities/1
  # DELETE /game_abilities/1.json
  def destroy
    if gm_user?
      @game_ability.destroy
      respond_to do |format|
        format.html { redirect_to game_abilities_url, notice: 'Game Ability was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to game_ability_path[@game_ability]
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_ability
      @game_ability = GameAbility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_ability_params
      params.require(:game_ability).permit(:name, :long_text, :item, :targets_another, :time_base, :time_function, :rounds_base, :rounds_function, :secret_action, :disruptable, :fate_cost_base, :fate_cost_function, :cooldown, :ability)
    end
end
