class User < ApplicationRecord
  has_many :posts
  has_many :comments, foreign_key: 'author_id', class_name: 'Comment'
  has_many :likes, foreign_key: 'author_id', class_name: 'Like'

  def most_recent_posts
    posts = Post.all
    posts.order(created_at: :desc).limit(3)
  end

  def update_posts_counter
    posts_counter = Post.where(author_id: id).count
    update(posts_counter: posts_counter)
  end
end
