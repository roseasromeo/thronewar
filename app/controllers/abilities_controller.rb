class AbilitiesController < ApplicationController
  before_action :set_ability, only: [:show, :edit, :update, :destroy]

  # GET /abilities
  # GET /abilities.json
  def index
    @abilities = Ability.all
  end

  # GET /abilities/1
  # GET /abilities/1.json
  def show
    if logged_in?
      @user = current_user
    else
      redirect_to login_path
    end
  end

  # GET /abilities/new
  def new
    @ability = Ability.new
    if admin_user?
      @ability = Ability.new
    else
      redirect_to abilities_path
    end
  end

  # GET /abilities/1/edit
  def edit
    if logged_in?
      @user = current_user
      if admin_user?

      else
        redirect_to abilities_path
      end
    else
      redirect_to login_path
    end
  end

  # POST /abilities
  # POST /abilities.json
  def create
    if logged_in?
      @user = current_user
      if admin_user?
        @ability = Ability.new(ability_params)

        respond_to do |format|
          if @ability.save
            format.html { redirect_to @ability, notice: 'Ability was successfully created.' }
            format.json { render :show, status: :created, location: @ability }
          else
            format.html { render :new }
            format.json { render json: @ability.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to abilities_path
      end
    else
      redirect_to login_path
    end
  end

  # PATCH/PUT /abilities/1
  # PATCH/PUT /abilities/1.json
  def update
    if logged_in?
      @user = current_user
      if admin_user?

        respond_to do |format|
          if @ability.update(ability_params)
            format.html { redirect_to @ability, notice: 'Ability was successfully updated.' }
            format.json { render :show, status: :ok, location: @ability }
          else
            format.html { render :edit }
            format.json { render json: @ability.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to root_path
      end
    else
      redirect_to login_path
    end
  end

  # DELETE /abilities/1
  # DELETE /abilities/1.json
  def destroy
    if logged_in?
      if admin_user?

        @ability.destroy
        respond_to do |format|
          format.html { redirect_to abilities_url, notice: 'Ability was successfully destroyed.' }
          format.json { head :no_content }
        end
      else
        redirect_to '/'
      end
    else
      redirect_to login_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ability
      @ability = Ability.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ability_params
      params.require(:ability).permit(:name, :short_text, :long_text, :level, :gift, :automatic, dependency_links_attributes: [:id, :parent_id, :depends_on_id, :_destroy])
    end
end
