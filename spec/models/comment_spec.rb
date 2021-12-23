require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    user = User.new(id: 1, name: 'hamza', posts_counter: 0)
    user.email = 'foo1@foo.com'
    user.password = 'admin123'
    user.password_confirmation = 'admin123'
    user.save
  end

  before :each do
    Post.create(id: 1, title: 'Anything', text: 'Lorem ipsum', comments_counter: 0, likes_counter: 0, author_id: 1)
  end
  subject do
    Comment.new(author_id: 1, post_id: 1, text: 'hahah you are crazy')
  end
  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a text' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'checks that "author_id" is an integer' do
    subject.author_id = 7.5
    expect(subject).to_not be_valid
  end

  it 'checks that "post_id" is an integer' do
    subject.post_id = 7.5
    expect(subject).to_not be_valid
  end
end
