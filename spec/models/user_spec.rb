require 'rails_helper'
require 'capybara/rspec'

RSpec.describe User, type: :model do
  context 'User associations tests' do
    it { should have_many(:friendship_invitations).with_foreign_key('user_id') }
    it { should have_many(:friends).class_name('FriendshipInvitation').with_foreign_key('friend_id') }
    it { should have_many(:likes) } 
    it { should have_many(:comments) } 
    it { should have_many(:posts) } 
  end
end