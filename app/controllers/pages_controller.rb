class PagesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  def index
  end

  def show
    @page = Page.find_by_name(params[:id])
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
