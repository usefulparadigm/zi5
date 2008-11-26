class Admin::BoardsController < Admin::AdminController
  
  make_resourceful do
    actions :index, :new, :create, :edit, :update, :destroy # :all
    response_for :create, :update do |format|
      format.html { redirect_to admin_boards_path }
    end
  end

  def current_object
    @current_object ||= current_model.find_by_name(params[:id])
  end

  def current_objects
    @current_object ||= current_model.paginate( :order => "created_at DESC", :page => params[:page], :per_page => 10 )
  end
  
end
