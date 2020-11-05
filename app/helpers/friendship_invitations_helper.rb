module FriendshipInvitationsHelper
  def friend_request?(user)
    current_user.friendship_invitations.find_by(friend_id: user.id).nil?
  end

  def pending_request?
    friendship_invitations.map { |friend| friend.friend unless friend.status }.compact
  end

  def friend_requests
    friends.map { |friend| friend.user unless friend.status }.compact
  end

  def confirm_request(user)
    friend = friends.find { |invite| invite.user == user }
    friend.status = true
    friend.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
