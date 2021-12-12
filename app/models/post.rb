class Post < ApplicationRecord
  belongs_to :editor, class_name: 'User'
  has_many :comments, foreign_key: 'post_id', class_name: 'Comment'
  has_many :likes, foreign_key: 'post_id', class_name: 'Like'

  def update_comments_counter
    comments_counter = Comment.where(post_id: id).count
    update(comments_counter: comments_counter)
  end

  def update_likes_counter
    likes_counter = Like.where(post_id: id).count
    update(likes_counter: likes_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
