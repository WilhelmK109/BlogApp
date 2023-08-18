class Like < ApplicationRecord
  belongs_to :author, foreign_key: 'author_id', class_name: 'User'
  belongs_to :post

  after_save :update_likes_counter

  private

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
