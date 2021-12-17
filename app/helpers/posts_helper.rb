module PostsHelper
  def truncate_text(text)
    "#{text[0..45]}..."
  end

  def posts?(posts)
      posts.empty? ? "You have no posts yet, Try to add a post 😊" : "Your recents posts"
  end
end
