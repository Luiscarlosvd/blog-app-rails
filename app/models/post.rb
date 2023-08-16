class Post < ApplicationRecord
  has_many :likes
  has_many :comments
  belongs_to :author, class_name: 'User'

  after_create :update_posts_counter

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
