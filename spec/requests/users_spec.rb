require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  subject { User.new(name: 'Waris', photo: 'Waris Profile', bio: 'Software Developer', postCounter: 2) }

  before { subject.save }

  describe 'GET #index' do
    before(:example) { get users_path }
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct routes' do
      expect(response).to render_template(:index)
    end

    it 'has the correct placeholder text in the response body' do
      expect(response.body).to include('This page lists all the users!')
    end
  end

  describe 'GET #show' do
    before(:example) { get user_path(id: 1) }
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct route' do
      expect(response).to render_template(:show)
    end

    it 'has the correct placeholder text in the response body' do
      expect(response.body).to include('This page lists one of the users!')
    end
  end
end
