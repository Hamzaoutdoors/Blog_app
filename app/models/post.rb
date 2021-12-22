class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id', class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  after_save :increment_posts_count
  after_destroy :decrement_posts_count

  validates :title, presence: true
  validates :text, presence: true, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def increment_posts_count
    user.increment!(:posts_counter)
  end

  def decrement_posts_count
    user.decrement!(:posts_counter)
  end

  def recent_comments
    comments.includes(:post).order(created_at: :desc).limit(5)
  end
end
