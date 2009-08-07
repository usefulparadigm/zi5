class HomeController < ApplicationController
  # here goes all static html pages
  caches_page :show

  def index
    render :action => :index 
  rescue
    redirect_to page_path(APP_CONFIG[:home_title])
  end

  def show
    render :action => params[:page]
  end

end
