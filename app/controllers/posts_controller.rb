class PostsController < ApplicationController
  before_filter :find_board, :except => [:home]
  before_filter :login_required_only_private, :except => [:home, :index, :show]

  PER_PAGE = 10

  def index
    if params[:swd]
      @posts = Post.title_or_body(params[:swd]).recent.paginate :page => params[:page], :per_page => PER_PAGE
      @post_count = @posts.size
      @title = "\"#{params[:swd]}\"에 대한 검색 결과"
    else
      @posts = @board.posts.recent.paginate :page => params[:page], :per_page => PER_PAGE
      @post_count = @board.posts.size
      @title = @board.title
    end  
		page = params[:page] ? params[:page].to_i : 1
    @start_no = @post_count - ((page-1) * PER_PAGE)
    respond_to do |format|
      format.html { render :action => 'search' if params[:swd] }
      format.atom
    end
  end

  def show
    index
    @post = @board.posts.find(params[:id], :include => :replies)
    @post.view request.remote_ip, current_user
  end

  def new
    @post = @board.posts.tmp!
    render :action => 'edit'
  end

  def edit
    @post = @board.posts.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    # TODO: 포스트에 대한 수정은 작성자만이 할 수 있다.
    @post.tmp = false
    @post.user = current_user
    @post.ip = request.remote_ip
    if @post.update_attributes(params[:post])
      redirect_to board_post_path(@board, @post)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @post = @board.posts.find(params[:id])
    @post.destroy
    redirect_to board_posts_path(@board)
  end

private
  def find_board
    @board ||= Board.find_by_name(params[:board_id])
  end
  
  def login_required_only_private
    login_required unless @board.public?
  end

end
