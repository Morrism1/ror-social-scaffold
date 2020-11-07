require 'rails_helper'

RSpec.describe 'Comments', type: :feature do
  let(:user) { User.create(name: 'Martin', email: 'martinpollo@gmail.com', password: 'kigali') }
  let(:friend) { User.create(name: 'Ghosh', email: 'terrific@gmail.com', password: 'nairobi') }

  scenario 'Make a comment on a post' do
    user.posts.build(content: 'best chicken quessadilla around').save
    user.friendship_invitations.build(friend_id: friend.id, status: true).save
    friend.friendship_invitations.build(friend_id: user.id, status: true).save
    visit root_path
    fill_in 'user_email', with: friend.email
    fill_in 'user_password', with: friend.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content(user.name)
    expect(page).to have_content('best chicken quessadilla around')
    fill_in 'comment_content', with: 'Yeah, I agree'
    click_on 'Comment'
    sleep(3)
    expect(page).to have_content('Comment was successfully created.')
    expect(page).to have_content(friend.name)
    expect(page).to have_content('Yeah, I agree')
  end
end
