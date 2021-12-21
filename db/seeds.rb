  names = [
	{ name: 'Nelsino', bio: "I'm the last oracle", posts_counter: 0, email:'foo1@foo.com', role: 'admin'},
	{ name: 'Hamza', bio: "I'm the First oracle", posts_counter: 0, email:'foo2@foo.com', role: 'admin'},
	{ name: 'Herbert', bio: "I'm the Best oracle", posts_counter: 0, email:'foo3@foo.com', role: 'admin'},
  { name: 'Laylo', bio: "I'm the sleep oracle", posts_counter: 0, email:'foo4@foo.com', role: 'user'},
  { name: 'Juan', bio: "I'm the bird oracle", posts_counter: 0, email:'foo5@foo.com', role: 'user'}
  ]

  for i in 0..4 do
    user = User.new(names[i])
    user.password = 'admin123'
    user.password_confirmation = 'admin123'
    user.save
  end
  
  all_users = User.all
  
  all_users.each do |user|
	for j in 1..5 do
	  Post.create(title: "Post number: #{j}", text: "I'm writing my post number: #{j}", comments_counter: 0, likes_counter: 0, author_id: user.id)
	end
  end
  
  all_posts = Post.all
  
  all_posts.each do |post|
	for j in 0..2 do
	  Like.create(author_id: all_users[j].id, post_id: post.id)
	  Comment.create(author_id: all_users[j].id, post_id: post.id, text: "I'm #{all_users[j].name} and I'm commenting gibberish here.")
	end
  end 