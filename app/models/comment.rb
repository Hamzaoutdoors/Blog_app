class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'
  after_save :update_comments_count

  validates :text, presence: true, length: { minimum: 1 }

  def update_comments_count
    post.increment!(:comments_counter)
  end

  def find_author
    User.find(author_id).name
  end
end
