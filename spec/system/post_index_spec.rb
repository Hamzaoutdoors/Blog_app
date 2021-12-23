require 'rails_helper'
require './spec/mocks_module'


RSpec.describe "post index view", type: :feature do

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

    it "can see user picture" do
      users = User.all

      users.each do |user|
        visit user_posts_path(user.id)
        img = page.find('img')

        expect(img['src']).to include(user.name)
      end
    end

    it "can see user username" do
      users = User.all
      
      users.each do |user|
        visit user_posts_path(user.id)

        expect(page).to have_content user.name
      end 
    end
      
    it "can see user post counter" do
      users = User.all

      users.each do |user|
        visit user_posts_path(user.id)

        expect(page).to have_content "Number of posts: #{user.posts_counter}"
      end
    end

    it "shows the header of the page" do
        users = User.all
    
        users.each do |user|
           visit user_posts_path(user.id)
          expect(page).to have_content "#{user.name}'s recents posts"
        end
      end

    it "can see post's title" do
      user = User.first
      posts = Post.order(:id).limit(2)
      visit user_posts_path(user.id)

      posts.each do |post|
        expect(page).to have_content "#{post.title} - ##{post.id}"
      end
    end

    it "can see some of post body" do
        user = User.first
        posts = Post.order(:id).limit(2)
        visit user_posts_path(user.id)
  
        posts.each do |post|
          expect(page).to have_content "#{post.text}"[0..10]
        end
    end

    it "can see recents comment for the post" do
        user = User.first
        post = Post.first
        visit user_posts_path(user.id)
      
       post.recent_comments do |comment|
        expect(page).to have_content comment.text
       end
    end

    it "can see how many comments a post has" do
        user = User.first
        post = Post.first
        visit user_posts_path(user.id)
        expect(page).to have_content "Comments: #{post.comments_counter}"
    end

    it "can see how many likes a post has" do
        user = User.first
        post = Post.first
        visit user_posts_path(user.id)
        expect(page).to have_content "Likes: #{post.likes_counter}"
    end

    it "can see pagination section" do
        user = User.first
        posts_counter = user.posts_counter
        pages_number = (posts_counter/2.00).ceil

        visit user_posts_path(user.id)

        expect(page).to have_content "Prev"
        expect(page).to have_content "Next"
        expect(page).to have_content pages_number
    end
  end

    # When I click on a post, it redirects me to that post's show page.

    context 'should redirect to post show path' do
        it "user can see the exact post" do
          user = User.first
          posts = Post.order(:id).limit(2)
          visit user_posts_path(user.id)
    
          posts.each do |post|
    
            a = all('a#post_container')
    
            a.each_with_index do |link, index|
                post = posts[index]
                link.click
              
              expect(current_path).to eq(user_post_path(user.id, post.id))
              visit user_posts_path(user.id)
            end 
          end
        end
      end
end
