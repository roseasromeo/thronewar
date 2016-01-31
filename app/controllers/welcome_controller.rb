class WelcomeController < ApplicationController
  helper_method :process_link

  def index
    @link_index = LinkIndex.where(title: 'welcome').first
    if @link_index == nil
      @link_index = LinkIndex.new(title: 'welcome')
    end
  end

  def edit
    if admin_user?
      @link_index = LinkIndex.where(title: 'welcome').first
      if @link_index == nil
        @link_index = LinkIndex.new(title: 'welcome')
      end
    else
      redirect_to root_path
    end
  end

  def update
    if admin_user?
      @link_index = LinkIndex.where(title: 'welcome').first
      if @link_index == nil
        @link_index = LinkIndex.new(title: 'welcome')
      end
      if @link_index.update(link_index_params)
        redirect_to root_path
      else
        render 'edit'
      end
    end
  end

  def process_link(link)
    if !link.include? '/'
      link = 'rules_pages/' + link
    end
    link
  end

  private
    def link_index_params
      params.require(:link_index).permit(:title, content_links_attributes: [:id, :name, :link, :order, :level, :_destroy])
    end
end
