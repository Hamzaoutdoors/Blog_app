class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, class_name: 'Post'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true
  validates_numericality_of :posts_counter, :greater_than_or_equal_to => 0

  def most_recent_posts
    Post.where(author_id: id).last(3)
  end
end
