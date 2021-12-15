module UsersHelper
  def image_url(user)
    user.photo || "https://ui-avatars.com/api/?name=#{user.name}&background=random"
  end

  def post_counter(user)
    user.posts_counter || 0
  end
end
