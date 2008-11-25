require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  context "A guest(anonymous user)" do
  end

  context "A logged-in user" do
    setup do 
      @user = login_as(:itsme)
      @board = boards(:open)
      @post = @board.posts.first
    end

    should "GET index" do
      get :index, :board_id => @board.name
      assert_response :success
      assert_not_nil assigns(:posts)
      assert_not_nil assigns(:post_count)
    end
    
    should "GET search" do
      get :search, :swd => "anything"
      assert_response :success
      assert_not_nil assigns(:posts)
      assert_not_nil assigns(:post_count)
      assert_template 'search'
    end

    should "GET show" do 
      get :show, :board_id => @board.name, :id => @post.id
      assert_response :success
      assert_not_nil assigns(:post)
    end  
    
    should "GET new" do
      get :new, :board_id => @board.name
      assert_response :success
      assert_not_nil assigns(:post)
    end
    
    should "POST create" do
      post :create, :board_id => @board.name, :post => { :title => "This is first post", :body => 'bla bla' }
      assert_not_nil assigns(:post)
      assert_redirected_to board_post_path(@board, assigns(:post))
    end

  end

end
