require './spec/rails_helper'

RSpec.describe Comment, type: :model do
  let(:author) { User.new(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Tester') }
  let(:post) { Post.new(author:, title: 'Post test', text: 'Description test') }
  subject { Comment.new(author:, post:, text: 'Description test') }

  before { subject.save }

  it 'belongs to a post' do
    expect(subject.post).to eq(post)
  end

  it 'belongs to an author' do
    expect(subject.author).to eq(author)
  end

  context 'update_comments_counter' do
    it 'updates the comments_counter of the post after creating a comment' do
      expect(post.comments_counter).to eq(1)
      Comment.create(author:, post:, text: 'Description test2')
      expect(post.comments_counter).to eq(2)
    end
  end
end
