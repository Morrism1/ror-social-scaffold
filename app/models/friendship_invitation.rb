class DuplicateValidator < ActiveModel::Validator
  def validate(record)
    friend1 = FriendshipInvitation.find_by(user_id: record.user_id, friend_id: record.friend_id)
    friend2 = FriendshipInvitation.find_by(friend_id: record.user_id, user_id: record.friend_id)
    record.errors[:base] << 'This relationship already exists' unless friend1.nil? && friend2.nil?
  end
end

class SelfInvitationValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << "You can't be friends with yourself" if record.user_id == record.friend_id
  end
end

class FriendshipInvitation < ApplicationRecord
  validates_with DuplicateValidator
  validates_with SelfInvitationValidator

  validates_presence_of :user_id, :friend_id, message: "can't be blank"
  validates_uniqueness_of :user_id, scope: [:friend_id]

  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
