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


describe "user index view", type: :feature do
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