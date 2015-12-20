class RulesPagesController < ApplicationController
  def index
    if logged_in?
      @rules_pages = RulesPage.all
    else
      redirect_to login_path
    end
  end

  def show
    if logged_in?
      @rules_page = RulesPage.find_by_slug(params[:id])
    else
      redirect_to login_path
    end
  end

  def new
    if logged_in?
      if admin_user?
        @rules_page = RulesPage.new
      else
        redirect_to '/'
      end
    else
      redirect_to login_path
    end
  end

  def edit
    if logged_in?
      @user = current_user
      if admin_user?
        @rules_page = RulesPage.find_by_slug(params[:id])
      else
        redirect_to '/'
      end
    else
      redirect_to login_path
    end
  end

  def create
    if logged_in?
      if admin_user?
        @rules_page = RulesPage.new(rules_page_params)

        if @rules_page.save
          redirect_to @rules_page
        else
          render 'new'
        end
      else
        redirect_to root
      end
    else
      redirect_to login_path
    end
  end

  def update
    if logged_in?
      @user = current_user
      if admin_user?
        @rules_page = RulesPage.find_by_slug(params[:id])

        if @rules_page.update(rules_page_params)
          redirect_to @rules_page
        else
          render 'edit'
        end
      else
        redirect_to root
      end
    else
      redirect_to login_path
    end
  end

  def destroy
    if logged_in?
      if admin_user?
        @rules_page = RulesPage.find_by_slug(params[:id])
        @rules_page.destroy

        redirect_to rules_pages_path
      else
        redirect_to '/'
      end
    else
      redirect_to login_path
    end
  end

  private
    def rules_page_params
      params.require(:rules_page).permit(:slug, :name, :title, :text, subpages_attributes: [:id, :subtitle, :order_number, :sidebar, :body, :_destroy])
    end
end
