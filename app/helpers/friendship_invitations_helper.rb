module FriendshipInvitationsHelper
  def pending_request?
    friendship_invitations.map { |friend| friend.friend unless friend.status }.compact
  end

  def friend_requests
    friends.map { |friend| friend.user unless friend.status }.compact
  end

  def friend?(user)
    friends.include?(user)
  end
end
