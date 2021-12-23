require 'rails_helper'

def create_users
  names = [
    { name: 'Nelsino', bio: "I'm the last oracle", posts_counter: 0, email:'foo1@foo.com', role: 'admin'},
    { name: 'Hamza', bio: "I'm the First oracle", posts_counter: 0, email:'foo2@foo.com', role: 'admin'},
    { name: 'Herbert', bio: "I'm the Best oracle", posts_counter: 0, email:'foo3@foo.com', role: 'admin'}
    ]
  
  for i in 0..2 do
    user = User.new(names[i])
    user.password = 'admin123'
    user.password_confirmation = 'admin123'
    user.save
  end

  User.all
end

def create_posts(users)
  users.each do |user|
    for j in 1..5 do
      Post.create(title: "Post number: #{j}", text: "I'm writing my post number: #{j}", comments_counter: 0, likes_counter: 0, author_id: user.id)
    end
  end

  Post.all
end

def create_likes_comments(users ,posts)
  posts.each do |post|
    for j in 0..2 do
      Like.create(author_id: users[j].id, post_id: post.id)
      Comment.create(author_id: users[j].id, post_id: post.id, text: "I'm #{users[j].name} and I'm commenting gibberish here.")
    end
  end 
end

describe "user show view", type: :feature do
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
        visit user_path(user.id)

        img = page.find('img')

        expect(img['src']).to include(user.name)

        visit root_path
      end
    end

    it "can see user username" do
      users = User.all
      
      users.each do |user|
        visit user_path(user.id)

        expect(page).to have_content user.name

        visit root_path
      end 
    end
      
    it "can see user post counter" do
      users = User.all

      users.each do |user|
        visit user_path(user.id)

        expect(page).to have_content "Number of posts: #{user.posts_counter}"

        visit root_path
      end
    end

    it "can see user bio" do
      users = User.all

      users.each do |user|
        visit user_path(user.id)

        expect(page).to have_content "BIO"
        expect(page).to have_content user.bio

        visit root_path
      end
    end

    it "can see user recent_posts" do
      users = User.all

      users.each do |user|
        visit user_path(user.id)

        recent_posts = user.most_recent_posts
        recent_posts.each do |post|
          expect(page).to have_content "Post ##{post.id}"
        end 
        
        visit root_path
      end
    end

    it "can see see all posts button" do
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
    it "user can see all users posts number" do
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
    it "can see all users posts number" do
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