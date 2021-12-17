require 'rails_helper'

RSpec.describe Like, type: :model do

  before :each do
    User.create(id: 1, name: 'hamza', posts_counter: 0)
  end

  before :each do
    Post.create(id: 1, title: "Anything", text: "Lorem ipsum", comments_counter: 0, likes_counter: 0, author_id: 1)
  end
    subject do
      Like.new(author_id: 1, post_id: 1)
    end
  before { subject.save }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
