require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject do
    Comment.new(post_id: 1, author_id: 2)
  end

  before do
    subject.save
  end

  it 'if created correctly' do
    expect(subject.post_id).to eq(1)
  end

  it 'checks if the post_id is integer' do
    subject.post_id = 1.1
    expect(subject).to_not be_valid
  end

  it 'testing update_comments_counter method' do
    author = User.create!(name: 'Waris', photo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3QNOHWG_Ib38C-BaplM6TJx6VIxJcK0gYXaT1SuTJGw&s', bio: 'Web Developer', posts_counter: 0)
    post = Post.create!(author:, title: 'test post', text: 'First post from Waris', comments_counter: 0, likes_counter: 0)
    Comment.create!(text: 'test comment', author:, post:)
    lastpost = Post.last
    expect(lastpost.comments_counter).to eq 1
  end
end
