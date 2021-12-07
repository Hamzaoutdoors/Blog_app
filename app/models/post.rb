class Post < ApplicationRecord
  belongs_to :editor, class_name: 'User'
  has_many :comments, foreign_key: 'post_id', class_name: 'Comment'
  has_many :likes, foreign_key: 'post_id', class_name: 'Like'


  def update_comments_counter
    comments_counter = Comment.where(post_id: id).count
    self.update(comments_counter: comments_counter)
  end

  def update_likes_counter
    likes_counter = Like.where(post_id: id).count
    self.update(likes_counter: likes_counter)
  end

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
