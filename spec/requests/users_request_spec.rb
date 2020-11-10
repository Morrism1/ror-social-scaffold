require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'User', type: :feature do
  let(:user) { User.create(name: 'Martin', email: 'martinpollo@gmail.com', password: 'kigali') }
  let(:friend) { User.create(name: 'Ghosh', email: 'terrific@gmail.com', password: 'nairobi') }

  scenario 'User sign in successfully' do
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')
  end
  scenario 'User sign in ends with failure' do
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'user.password'
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Invalid Email or password.')
  end
end

RSpec.describe UsersController, type: :controller do
  login_user
  context 'GET users controller views' do
    it 'GET #index' do
      get :index
      expect(response).to be_successful
    end
    it 'GET #new/sign up page' do
      get :show, params: { id: 1 }
      expect(response).to be_successful
    end
  end
end
