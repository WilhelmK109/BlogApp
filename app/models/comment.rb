class Comment < ApplicationRecord
  belongs_to :author, foreign_key: 'author_id', class_name: 'User'
  belongs_to :post

  after_create :update_comments_counter

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
