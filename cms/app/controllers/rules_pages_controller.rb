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
    @rules_page = Article.find(params[:id])
  end

  def create
    @rules_page = RulesPage.new(rules_page_params);

    if @rules_page.save
      redirect_to @rules_page
    else
      render 'new'
    end
  end
end

private
  def rules_page_params
    params.require(:rules_page).permit(:title, :text)
  end
