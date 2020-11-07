require 'rails_helper'

RSpec.describe "FriendshipInvitations", type: :feature do
    let(:user) { User.create(name: 'Martin', email: 'martinpollo@gmail.com', password: 'kigali') }
    let(:friend) { User.create(name: 'Ghosh', email: 'terrific@gmail.com', password: 'nairobi') }
  
    scenario 'Send friend request from Users index page' do
      friend = User.create(name: 'Ghosh', email: 'terrific@gmail.com', password: 'nairobi')
      visit root_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on 'Log in'
      sleep(3)
      expect(page).to have_content('Signed in successfully.')
      click_on 'All users'
      sleep(3)
      expect(page).to have_content("Name: #{friend.name}")
      expect(page).to have_button('Add friend')
      first('.btn-secondary').click
      sleep(3)
      expect(page).to have_content('Friend request was successfully sent.')
    end
    scenario 'Send friend request from Users show page' do
      friend = User.create(name: 'Ghosh', email: 'terrific@gmail.com', password: 'nairobi')
      visit root_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on 'Log in'
      sleep(3)
      expect(page).to have_content('Signed in successfully.')
      click_on 'All users'
      sleep(3)
      expect(page).to have_content("Name: #{friend.name}")
      first('.profile-link').click 
      sleep(3)
      expect(page).to have_content("Name: #{friend.name}")
      expect(page).to have_button('Add friend')
      click_on 'Add friend'
      sleep(3)
      expect(page).to have_content('Friend request was successfully sent.')
    end
    scenario 'Accept friendship' do
      user.friendship_invitations.build(friend_id: friend.id, status: false).save
      visit root_path
      fill_in 'user_email', with: friend.email
      fill_in 'user_password', with: friend.password
      click_on 'Log in'
      sleep(3)
      expect(page).to have_content('Signed in successfully.')
      click_on 'Friend Requests'
      sleep(3)
      expect(page).to have_content("Name: #{user.name}")
      expect(page).to have_button('Accept')
      expect(page).to have_button('Decline')
      click_on 'Accept'
      sleep(3)
      expect(page).to have_content('Friend request was successfully confirmed')
      expect(page).to have_content("Name: #{friend.name}")
    end
    scenario 'Decline friendship' do
      user.friendship_invitations.build(friend_id: friend.id, status: false).save
      visit root_path
      fill_in 'user_email', with: friend.email
      fill_in 'user_password', with: friend.password
      click_on 'Log in'
      sleep(3)
      expect(page).to have_content('Signed in successfully.')
      click_on 'Friend Requests'
      sleep(3)
      expect(page).to have_content("Name: #{user.name}")
      expect(page).to have_button('Accept')
      expect(page).to have_button('Decline')
      click_on 'Decline'
      sleep(3)
      expect(page).to have_content('Friend request declined, we won\'t inform the user')
      expect(page).to have_content("Name: #{friend.name}")
    end
end
