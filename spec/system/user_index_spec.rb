require 'rails_helper'
require './spec/mocks_module'


RSpec.describe "user index view", type: :feature do
  include Mocks

  before :each do
    users = create_users
    posts = create_posts(users)
    create_likes_comments(users, posts)

    visit new_user_session_path

    within("form") do
      fill_in 'user_email', with: 'foo1@foo.com'
      fill_in 'user_password', with: 'admin123'
    end
    click_button 'Log in'
  end

  context "displaying correctly" do
    
    it "can see all users name" do
      users = User.all

      users.each do |user|
        expect(page).to have_content user.name
      end
    end

    it "can see all users photos" do
      users = User.all.order(:id)
      imgs = page.all('img')

      users.each_with_index do |user, index|
        expect(imgs[index]['src']).to include(user.name)
      end
      expect(imgs.length).to be(users.length) 
    end
      
    it "can see all users posts number" do
      users = User.all

      users.each do |user|
        expect(page).to have_content "Number of posts: #{user.posts_counter}"
      end
    end
  end

  context 'is redirect to user_show_path' do
    it "can see all users posts number" do
      users = User.all

      users.each do |user|
        click_link user.name
        expect(current_path).to eq(user_path(user.id))
        visit root_path
      end
    end
  end
end