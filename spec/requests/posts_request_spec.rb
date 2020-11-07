require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  let(:user) { User.create(name: 'Martin', email: 'martinpollo@gmail.com', password: 'kigali') }
  let(:friend) { User.create(name: 'Ghosh', email: 'terrific@gmail.com', password: 'nairobi') }

  scenario 'Create new post' do
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    sleep(3)
    fill_in 'post_content', with: 'best chicken quessadilla around'
    click_on 'Save'
    sleep(3)
    expect(page).to have_content('Post was successfully created.')
    expect(page).to have_content(user.name)
    expect(page).to have_content('best chicken quessadilla around')
  end

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
    fill_in 'comment_content', with: 'Yes, he was'
    click_on 'Comment'
    sleep(3)
    expect(page).to have_content('Comment was successfully created.')
    expect(page).to have_content(friend.name)
    expect(page).to have_content('Yes, he was')
  end

  scenario 'See posts from the user and his or her friends in the Timeline' do
    friend.posts.build(content: 'Hello Ghosh').save
    user.posts.build(content: 'Hello Martin').save
    user.friendship_invitations.build(friend_id: friend.id, status: true).save
    friend.friendship_invitations.build(friend_id: user.id, status: true).save

    visit root_path
    fill_in 'user_email', with: friend.email
    fill_in 'user_password', with: friend.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content(user.name)
    expect(page).to have_content('Hello Martin')
    expect(page).to have_content(friend.name)
    expect(page).to have_content('Hello Ghosh')

    click_on 'Timeline'
    sleep(3)
    expect(page).to have_content(user.name)
    expect(page).to have_content('Hello Ghosh')
    expect(page).to have_content(friend.name)
    expect(page).to have_content('Hello Martin')
  end
end
