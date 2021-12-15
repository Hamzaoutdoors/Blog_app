class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'post_id', class_name: 'Comment', dependent: :destroy
  has_many :likes, foreign_key: 'post_id', class_name: 'Like', dependent: :destroy
  after_save :update_posts_count

  def update_posts_count
    user.increment!(:posts_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
