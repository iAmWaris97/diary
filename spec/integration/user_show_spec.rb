require 'rails_helper'

RSpec.describe 'User show Page', type: :feature do
  before :each do
    @user = User.create(name: 'Waris Haleem', photo: 'waris.png', bio: 'Software Developer', posts_counter: 12)
    @post = Post.create(title: 'Ruby', text: 'Ruby is fun to learn', comments_counter: 7, likes_counter: 6,
                        author: @user)
  end

  describe 'User show page' do
    before(:each) { visit user_path(id: @user.id) }

    it 'show a container for the users' do
      expect(page).to have_css('section.one_user_container')
    end

    it "shows the user's profile picture" do
      expect(page.has_xpath?("//img[@src = '#{@user.photo}' ]"))
    end

    it "shows the user's username" do
      expect(page).to have_content(@user.name)
      expect(page).to have_link(@user.name, href: user_path(id: @user.id))
    end

    it 'shows the number of posts the user has posted' do
      expect(page).to have_content("Number of posts: #{@user.posts_counter || 0}")
    end

    it "shows the user's bio" do
      expect(page).to have_content('Bio')
      expect(page).to have_content(@user.bio)
    end

    it 'shows the first 3 posts of the user' do
      @user.last_three_posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'has a button to view all user posts' do
      expect(page).to have_link('See all Posts', href: user_posts_path(user_id: @user.id))
    end


    it 'redirects to the post show page on clicking a user post' do
      click_link(@post.text)
      expect(page).to have_current_path(user_post_path(@user, @post))
    end

    it 'redirects to open all posts of a user' do
      click_link('See all Posts')
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end
