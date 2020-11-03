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
    sent_invitation = friendship_invitations.map { |friendship| friendship.friend if friendship.status}
    sent_invitation += friends.map { |friendship| friendship.user if friendship.confirmed }
    sent_invitation.compact
  end

  def friends?(user)
    friends.includes(user)
  end

  def sent_invitation(user)
    FriendshipInvitation.create(friend_id: user.id)
  end
end
