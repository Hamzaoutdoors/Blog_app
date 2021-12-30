# rubocop:disable Metrics/BlockLength
require 'rails_helper'
require './spec/mocks_module'

RSpec.describe 'user show view', type: :feature do
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
  end

  context 'displaying correctly' do
    it 'can see user picture' do
      users = User.all

      users.each do |user|
        visit user_path(user.id)

        img = page.find('img')

        expect(img['src']).to include(user.name)

        visit root_path
      end
    end

    it 'can see user username' do
      users = User.all

      users.each do |user|
        visit user_path(user.id)

        expect(page).to have_content user.name

        visit root_path
      end
    end

    it 'can see user post counter' do
      users = User.all

      users.each do |user|
        visit user_path(user.id)

        expect(page).to have_content "Number of posts: #{user.posts_counter}"

        visit root_path
      end
    end

    it 'can see user bio' do
      users = User.all

      users.each do |user|
        visit user_path(user.id)

        expect(page).to have_content 'BIO'
        expect(page).to have_content user.bio

        visit root_path
      end
    end

    it 'can see user recent_posts' do
      users = User.all

      users.each do |user|
        visit user_path(user.id)

        recent_posts = user.most_recent_posts
        recent_posts.each do |post|
          expect(page).to have_content "#{post.title} - ##{post.id}"
        end

        visit root_path
      end
    end

    it 'can see see all posts button' do
      users = User.all

      users.each do |user|
        visit user_path(user.id)

        expect(page).to have_content 'See all posts'

        visit root_path
      end
    end
  end

  # When I click a user's post, it redirects me to that post's show page.

  context 'should redirect to post path' do
    it 'user can see all users posts number' do
      users = User.all

      users.each do |user|
        visit user_path(user.id)

        recent_posts = user.most_recent_posts
        a = all('a#post_container')

        a.each_with_index do |link, index|
          visit user_path(user.id)
          post = recent_posts[index]
          link.click

          expect(current_path).to eq(user_post_path(user.id, post.id))
        end
        visit root_path
      end
    end
  end

  # When I click to see all posts, it redirects me to the user's post's index page.

  context 'should redirect to post index view' do
    it 'can see all users posts number' do
      users = User.all

      users.each do |user|
        visit user_path(user.id)

        click_link 'See all posts'

        expect(current_path).to eq(user_posts_path(user.id))

        visit root_path
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
