class User < ApplicationRecord
  has_many :posts
  has_many :comments, foreign_key: 'author_id', class_name: 'Comment'
  has_many :likes, foreign_key: 'author_id', class_name: 'Like'
 

  def most_recent_posts
    Post.where(author_id: id).last(3)
  end
end
