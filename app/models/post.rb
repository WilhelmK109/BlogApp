class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  belongs_to :author, class_name: 'User'
  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  after_create :update_author_posts_count

  def update_author_posts_count
    author.update(posts_counter: author.posts.count)
  end

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
