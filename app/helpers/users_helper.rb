module UsersHelper
  def image_url(user)
    user.photo || "https://ui-avatars.com/api/?name=#{user.name}&background=random"
  end

  def post_counter(user)
    user.posts_counter || 0
  end

  def posts?(posts)
    posts.empty? ? "You have no posts yet, Try to add a post 😊" : "#{@user.name}\'s recents posts"
end
end
