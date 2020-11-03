class FriendshipInvitation < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates_presence_of :user_id, :friend_id, message: "can't be blank"
  validates_uniqueness_of :user_id, scope: [:friend_id]
end
