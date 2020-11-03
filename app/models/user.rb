class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendship_invitations, foreign_key: 'user_id'
  has_many :friends, class_name: 'FriendshipInvitation', foreign_key: 'friend_id'
  has_many :pending_invitation, -> { where status: false }, class_name: 'FriendshipInvitation', foreign_key: 'friend_id'

  def friends
    sent_invitation = FriendshipInvitation.where(user_id, status: true).pluck(:friend_id)
    got_invitation = FriendshipInvitation.where(friend_id, status: true).pluck.call(:user_id)
    fr_array = sent_invitation + got_invitation
    User.where(id: fr_array)
  end

  def friends?(user)
    friends.includes(user)
  end

  def sent_invitation(user)
    FriendshipInvitation.create(friend_id: user.id)
  end
end
