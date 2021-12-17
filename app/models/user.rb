class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, class_name: 'Post'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def most_recent_posts
    Post.includes(:user).where(author_id: id).last(3)
  end
end
