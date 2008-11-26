class PostsController < ApplicationController
  before_filter :find_board, :except => [:home, :search]
  before_filter :check_open_level, :except => [:home, :search]
  protect_forms_from_spam :only => [:new, :edit, :show]

  PER_PAGE = 10

  def index 
    find_posts
    @feed_url = formatted_board_posts_url(@board, :atom)
    respond_to do |format|
      format.html
      format.atom
    end
  end
  
  def search
    @posts = Post.title_or_body_like(params[:swd]).recent.paginate :page => params[:page], :per_page => PER_PAGE
    @post_count = @posts.size
  end

  def show
    @post = @board.posts.find(params[:id], :include => :replies)
    find_posts
    @post.view request.remote_ip, current_user
  end

  def new
    # @post = @board.posts.tmp!
    # render :action => 'edit'
    @post = @board.posts.build
  end

  def create
    @post = @board.posts.build(params[:post])
    @post.user = current_user
    @post.ip = request.remote_ip
    if @post.save 
      redirect_to board_post_path(@board, @post)
    else
      #error_stickie(@post.errors.full_messages.first)
      render :action => 'new'
    end
  end

  def edit
    @post = @board.posts.find(params[:id])
  end

  def update
    # TODO: 포스트에 대한 수정은 작성자만이 할 수 있다.
    @post = current_user.posts.find(params[:id])
    # @post.tmp = false
    # @post.user = current_user
    @post.ip = request.remote_ip # it goes to callback
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
  
  # def login_required_only_private
  #   login_required unless @board.public?
  # end

  def find_posts
    @posts = @board.posts.recent.paginate :page => params[:page], :per_page => PER_PAGE
    @post_count = @board.posts.count
		page = params[:page] ? params[:page].to_i : 1
    @start_no = @post_count - ((page-1) * PER_PAGE)
  end

  def check_open_level
    case
    when action_name == 'index'
      login_required if @board.open_level < OpenLevel::LIST_ONLY
    when action_name == 'show'
      login_required if @board.open_level < OpenLevel::READ_ONLY
    else
      login_required if @board.open_level < OpenLevel::OPEN
    end
  end
  
end
