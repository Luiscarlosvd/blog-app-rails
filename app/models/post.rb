class Post < ApplicationRecord
  before_validation :set_default_likes_n_comment_counters

  has_many :likes
  has_many :comments
  belongs_to :author, class_name: 'User'
  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :update_posts_counter

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def set_default_likes_n_comment_counters
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end
end
