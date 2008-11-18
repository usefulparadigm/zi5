module PostsHelper
  
  def link_to_author(post)
    if post.user
      post.user
      # link_to post.user #, user_path(post.user)
    else
      link_to_unless post.homepage.blank?, post.author, post.homepage
    end
  end
  
end
