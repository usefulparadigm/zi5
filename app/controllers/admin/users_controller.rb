class Admin::UsersController < Admin::AdminController
  
  make_resourceful do
    actions :index, :edit, :update, :destroy # :all
  end

  def current_object
    @current_object ||= current_model.find_by_login(params[:id])
  end

  def current_objects
    @current_object ||= current_model.paginate( :order => "created_at DESC", :page => params[:page], :per_page => 20 )
  end
  
end
