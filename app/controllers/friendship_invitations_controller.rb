class FriendshipInvitationsController < ApplicationController
  def create
    @friendship = current_user.friendship_invitations.build(friend_id: params[:user_id])
    @friendship.status = false
    if @friendship.save
      redirect_to request.referrer, notice: 'Friend request was successfully sent.'
    else
      redirect_to request.referrer, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  def index
    @friendships = current_user.friendship_invitations
    @friends = current_user.friends
  end

  def update
    @friendship = FriendshipInvitation.find(params[:id])
    @friendship.status = true

    if @friendship.save
      redirect_to user_path(current_user.id), notice: 'Friend request was successfully confirmed.'
    else
      redirect_to user_path(current_user.id), alert: @friendship.error.full_messages.join('. ').to_s
    end
  end

  def destroy
    @friendship = FriendshipInvitation.find_by(friend_id: current_user.id, user_id: params[:user_id])
    if @friendship.destroy
      redirect_to user_path(current_user.id), notice: 'Friend request declined, we won\'t inform the user'
    else
      redirect_to user_path(current_user.id), alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end
end
