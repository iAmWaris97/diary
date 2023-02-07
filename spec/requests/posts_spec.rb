require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  user = User.create(name: 'Waris', photo: 'https://yagankar.com/storage/avatars/287_sfqVYTzjweOQJvBqOSunbAaMR1rHRNcbXxU7FcV2.jpg', bio: 'Software Developer', posts_counter: 5)
  subject do
    Post.new(title: 'Something', text: 'A post from Waris!', comments_counter: 20, likes_counter: 16,
             author: user)
  end

  before { subject.save }

  describe 'GET #index' do
    before(:each) { get user_posts_path(user_id: 1) }
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct route' do
      expect(response).to render_template(:index)
    end
  end
  describe 'GET #show' do
    before(:each) { get user_post_path(user_id: 1, id: 1) }
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct route' do
      expect(response).to render_template(:show)
    end

    it 'has the correct placeholder text in the response body' do
      expect(response.body).to include('This page lists one post of a user!')
    end
  end
end
