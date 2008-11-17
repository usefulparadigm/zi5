atom_feed(:url => formatted_board_url(@board, :atom)) do |feed|
  feed.title(APP_CONFIG[:site_name] + ' - ' + @title)
  feed.updated(@posts.first ? @posts.first.created_at : Time.now.utc)

  for post in @posts
    feed.entry([post.board, post]) do |entry|
      entry.title(post.title)
      entry.content(post.body, :type => 'html')

      entry.author do |author|
        author.name(post.user)
        #author.email(post.user.email)
      end
    end
  end
end
