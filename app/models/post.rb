class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id', class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  after_save :update_posts_count 

  validates :title, presence: true
  validates :text, presence: true, length: {maximum: 250}
  validates_numericality_of :comments_counter, :likes_counter, :greater_than_or_equal_to => 0

  def update_posts_count
    user.increment!(:posts_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end

