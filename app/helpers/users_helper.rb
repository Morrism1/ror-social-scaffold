module UsersHelper
  def user_info(user)
    render partial: 'user_info', locals: { user: user } unless current_user?(user)
  end

  def friend_request(user)
    return unless current_user.friend_confirmed?(user) && !current_user?(user)

    render partial: 'friend_request', locals: { user: user }
  end

  def current_user?(user)
    current_user == user
  end
end
