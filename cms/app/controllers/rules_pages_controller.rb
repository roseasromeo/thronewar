class RulesPagesController < ApplicationController
  def index
    @rules_pages = RulesPage.all
  end

  def show
    @rules_page = RulesPage.find(params[:id])
  end

  def new
    @rules_page = RulesPage.new
  end

  def edit
    @rules_page = RulesPage.find(params[:id])
  end

  def create
    @rules_page = RulesPage.new(rules_page_params)

    if @rules_page.save
      redirect_to @rules_page
    else
      render 'new'
    end
  end

  def update
    @rules_page = RulesPage.find(params[:id])

    if @rules_page.update(rules_page_params)
      redirect_to @rules_page
    else
      render 'edit'
    end
  end

  def destroy
    @rules_page = RulesPage.find(params[:id])
    @rules_page.destroy

    redirect_to rules_pages_path
  end

  private
    def rules_page_params
      params.require(:rules_page).permit(:title, :text)
    end
end
