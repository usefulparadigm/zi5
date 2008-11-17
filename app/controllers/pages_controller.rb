class PagesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  def index # search
    # @results = Page.where_title(params[:swd]) + Post.where_title(params[:swd])
    # @results = @results.paginate :page => params[:page] #+ Posts.where_title(params[:swd])
    # @posts = Post.where_title(params[:swd]).paginate :page => params[:page]
  end

  def show
    @page = Page.find_by_name(params[:id])
    render :action => 'home' if params[:id] == APP_CONFIG[:home_title]
  rescue  
  ensure  
    new unless @page
  end

  def new
    @page = Page.create(:title => params[:id], :name => params[:id])
    render :action => 'edit'
  end
  
  def edit
    @page = Page.find_by_name(params[:id])
  end

  def update
    @page = Page.find_by_name(params[:id])
    @page.user = current_user
    if @page.update_attributes(params[:page])
      redirect_to @page
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page = Page.find_by_name(params[:id])
    @page.destroy
    redirect_to root_path
  end
end
