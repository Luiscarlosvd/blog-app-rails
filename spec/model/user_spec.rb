require './spec/rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Tester') }

  before { subject.save }

  context 'Validation' do
    it 'should have the name present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should have posts_counters set to 0 or greater than 0' do
      subject.posts_counter = 0
      expect(subject).to be_valid
    end
  end

  context 'recent_posts' do
    it 'should return the 3 most recent posts when using recent_posts' do
      post1 = Post.create(author: subject, title: 'test', text: 'test', created_at: Time.now - 2.days)
      post2 = Post.create(author: subject, title: 'test2', text: 'test', created_at: Time.now - 1.day)
      post3 = Post.create(author: subject, title: 'test3', text: 'test', created_at: Time.now)

      expect(subject.recent_posts).to eq([post3, post2, post1])
    end
  end

  describe 'set_default_posts_counter' do
    it 'should set the posts_counter to 0 when you create a new instance of User' do
      expect(subject.posts_counter).to eq(0)
    end
  end
end
