require 'rails_helper'
require './spec/mocks_module'

RSpec.describe 'post show view', type: :feature do
  include Mocks

  before :each do
    users = create_users
    posts = create_posts(users)
    create_likes_comments(users, posts)

    visit new_user_session_path

    within('form') do
      fill_in 'user_email', with: 'foo1@foo.com'
      fill_in 'user_password', with: 'admin123'
    end
    click_button 'Log in'
    @user = User.first
    @post = Post.first
    visit user_post_path(@user.id, @post.id)
  end

  context 'displaying correctly' do
    it "can see post's title" do
      expect(page).to have_content "#{@post.title}"
    end

    it 'can see some of post body' do
      expect(page).to have_content "I'm writing my post number: 1"
    end

    it 'can see how many comments a post has' do
      expect(page).to have_content "Comments: #{@post.comments_counter}"
    end

    it 'can see how many likes a post has' do
      expect(page).to have_content "Likes: #{@post.likes_counter}"
    end

    it 'can see some of post body' do
      expect(page).to have_content @post.text
    end

    it 'can see the username of each commentor.' do
      comments = @post.comments
      comments.each do |comment|
        expect(page).to have_content comment.user.name
        expect(page).to have_content comment.text
      end
    end
  end
end
