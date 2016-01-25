class RulesPagesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

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
      if @rules_page == nil
        redirect_to rules_pages_path
      end
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

  def import
    if request.post?
      @parsed = true
      text = params[:content]
      @parsed_text = parse_rules(text)
      @text = params[:content]
      @name = params[:name]

      error = false

      # Grab title and intro text
      title = strip_tags(@parsed_text[1])
      intro = @parsed_text[2]

      @rules_page = RulesPage.new(slug: params[:name].gsub(" ","").gsub("\'",""), name: params[:name], title: title, text: intro)
      if @rules_page.save() #right now, not checking for errors...
        for i in 0..((@parsed_text.length - 3)/2 - 1)
          puts i
          subtitle = strip_tags(@parsed_text[3 + 2*i])
          body = @parsed_text[4 + 2*i]
          if body.strip == ''
            body = ''
          end
          subpage = Subpage.new(rules_page: @rules_page, subtitle: subtitle, body: body, sidebar: '', order_number: i)
          if subpage.save()
            # nothing right now
          else
            error = true
          end
        end
        if error == true
          @rules_page.destroy
        else
          redirect_to rules_page_path(@rules_page)
        end
      else
        error = true
        flash[:error] = "Error saving. Check that \#? are paired."
      end

    else
      #If need anything in get view?
      @text = ''
      @name = ''
      @parsed = false
    end
  end

  private
    def rules_page_params
      params.require(:rules_page).permit(:slug, :name, :title, :text, subpages_attributes: [:id, :subtitle, :order_number, :sidebar, :body, :_destroy])
    end

    def parse_rules(text)
      parsed_text = []
      sanitized_text = ActionController::Base.helpers.sanitize(text, :tags => %w(p strong b i u table tr th td a), :attributes => %w(href))
      stored_text = ""
      sanitized_text.split("<p").each do |line|
        if line.include?("\#?")
          stored_text = stored_text.gsub(/\n/," ").gsub(/\r/," ").gsub(/<p>[^1234567890abcdefghijklmnopqrstuvwxyz]<\/p>/,'').gsub(/<p><\/p>/,'')
          parsed_text << stored_text
          stored_text = "<p" + line.gsub("\#?","").gsub(/(&nbsp;|\s)+/," ")
        else
          stored_text = stored_text + "<p" + line.gsub(/(&nbsp;|\s)+/," ")
        end
      end
      parsed_text << stored_text
      parsed_text
    end


end
