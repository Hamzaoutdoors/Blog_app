require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Anything', bio: 'Lorem ipsum', photo: 'https://ui-avatars.com/api/?name=sara&background=random',
             posts_counter: 1, email: 'foo1@foo.com')
  end
  before { subject.save }

  it 'is valid with valid attributes' do
    subject.password = 'admin123'
    subject.password_confirmation = 'admin123'
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.password = 'admin123'
    subject.password_confirmation = 'admin123'
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with posts_counter negative' do
    subject.password = 'admin123'
    subject.password_confirmation = 'admin123'
    subject.posts_counter = -5
    expect(subject).to_not be_valid
  end

  it 'is not valid with posts_counter not integer' do
    subject.password = 'admin123'
    subject.password_confirmation = 'admin123'
    subject.posts_counter = 7.7
    expect(subject).to_not be_valid
  end
end
