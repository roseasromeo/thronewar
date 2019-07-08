class PromptValuesController < ApplicationController
  before_action :set_prompt_value, only: [:show, :edit, :update, :destroy]

  # GET /prompt_values
  # GET /prompt_values.json
  def index
    @prompt_values = PromptValue.all
  end

  # GET /prompt_values/1
  # GET /prompt_values/1.json
  def show
  end

  # GET /prompt_values/new
  def new
    @prompt_value = PromptValue.new
  end

  # GET /prompt_values/1/edit
  def edit
  end

  # POST /prompt_values
  # POST /prompt_values.json
  def create
    @prompt_value = PromptValue.new(prompt_value_params)

    respond_to do |format|
      if @prompt_value.save
        format.html { redirect_to @prompt_value, notice: 'Prompt value was successfully created.' }
        format.json { render :show, status: :created, location: @prompt_value }
      else
        format.html { render :new }
        format.json { render json: @prompt_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prompt_values/1
  # PATCH/PUT /prompt_values/1.json
  def update
    respond_to do |format|
      if @prompt_value.update(prompt_value_params)
        format.html { redirect_to @prompt_value, notice: 'Prompt value was successfully updated.' }
        format.json { render :show, status: :ok, location: @prompt_value }
      else
        format.html { render :edit }
        format.json { render json: @prompt_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prompt_values/1
  # DELETE /prompt_values/1.json
  def destroy
    @prompt_value.destroy
    respond_to do |format|
      format.html { redirect_to prompt_values_url, notice: 'Prompt value was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prompt_value
      @prompt_value = PromptValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prompt_value_params
      params.require(:prompt_value).permit(:prompt_id, :active_ability_id, :value)
    end
end
