require 'rails_helper'
require 'capybara/rspec'
RSpec.describe FriendshipInvitation, type: :model do
  subject { FriendshipInvitation.new }
  let(:user) { User.create(name: 'Martin', email: 'martinpollo@gmail.com', password: 'kigali') }
  let(:friend) { User.create(name: 'Ghosh', email: 'terrific@gmail.com', password: 'nairobi') }
  context 'Validation tests' do
    it 'valid with user and friend' do
      subject.user = user
      subject.friend = friend
      expect(subject).to be_valid
    end

    it 'not valid without a friend' do
      subject.user = user
      expect(subject).to_not be_valid
    end

    it 'not valid without a user' do
      subject.friend = friend
      expect(subject).to_not be_valid
    end

    it 'adds a new Friendship' do
      count = FriendshipInvitation.count
      subject.update!(user: user, friend: friend, status: true)
      expect(FriendshipInvitation.count).to eq(count + 1)
    end
  end
  context 'Other Validation tests' do
    it 'validates against duplicate friendship' do
      user.friendship_invitations.build(friend: friend, status: false).save
      subject.user = user
      subject.friend = friend
      expect { subject.save! }.to raise_error(
        ActiveRecord::RecordInvalid,
        'Validation failed: This relationship already exists, User has already been taken'
      )
    end

    it 'validates against duplicate inverse-friendship' do
      user.inverse_friendships.build(user: friend, status: false).save
      subject.user = user
      subject.friend = friend
      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid,
                                              'Validation failed: This relationship already exists')
    end

    it 'validates against self-friendship' do
      subject.user = user
      subject.friend = user
      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid,
                                              "Validation failed: You can't be friends with yourself")
    end
  end
  context 'Friendships associations tests' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end
end
