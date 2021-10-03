# frozen_string_literal: true

# location: spec/feature/oauth_integration_spec.rb
require 'rails_helper'

feature 'testing oauth' do
  fixtures :users
  scenario 'should create a new user with an @tamu.edu email' do
    OmniAuth.config.mock_auth[:google_oauth2].info.email = 'john.doe@tamu.edu'
    visit user_google_oauth2_omniauth_authorize_path
    expect(page).to have_content('Successfully authenticated from Google account')
  end

  scenario 'should not create a new user with an email other than @tamu.edu' do
    OmniAuth.config.mock_auth[:google_oauth2].info.email = 'john.doe@gmail.com'
    visit user_google_oauth2_omniauth_authorize_path
    expect(page).to have_content('is not authorized')
  end
end
