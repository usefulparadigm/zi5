class Admin::BoardsController < ApplicationController
  before_filter :admin_required
  
  make_resourceful do
    actions :all
  end

  def current_object
    @current_object ||= current_model.find_by_name(params[:id])
  end

  def current_objects
    @current_object ||= current_model.paginate( :order => "created_at DESC", :page => params[:page], :per_page => 10 )
  end
  
end
