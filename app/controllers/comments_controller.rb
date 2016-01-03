class CommentsController < ApplicationController

  def create
    @rules_page = RulesPage.find_by_slug(params[:rules_page_id])
    @user = current_user
    @comment = @rules_page.comments.create(body: comment_params[:body], user: @user)
    redirect_to rules_page_path(@rules_page)
  end

  def destroy
    @rules_page = RulesPage.find_by_slug(params[:rules_page_id])
    @comment = @rules_page.comments.find(params[:id])
    @comment.destroy
    redirect_to rules_page_path(@rules_page)
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
