# frozen_string_literal: true

# location: spec/feature/profile_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Editing an profile', type: :feature do
  fixtures :users

  scenario 'valid inputs' do
    login_as_admin
    visit "/profiles/#{users(:admin_account).id}/edit"
    fill_in 'Edit Description', with: 'new_test_desc'
    # fill_in 'Picture', with: 'test_pic'
    click_on 'Save Changes'
    expect(page).to have_content 'new_test_desc'
  end

  scenario 'non-admin user' do
    login_as_user
    visit "/profiles/#{users(:user_account).id}/edit"
    fill_in 'Edit Description', with: 'new_test_desc'
    # fill_in 'Picture', with: 'test_pic'
    click_on 'Save Changes'
    expect(page).to have_content 'new_test_desc'
  end

  scenario 'non-permit user' do
    login_as_user
    visit "/profiles/#{users(:admin_account).id}/edit"
    expect(page).to have_current_path root_path, ignore_query: true
  end

  scenario 'non-permit admin' do
    login_as_admin
    visit "/profiles/#{users(:user_account).id}/edit"
    expect(page).to have_current_path root_path, ignore_query: true
  end
  #
  # scenario 'valid inputs url' do
  #   login_as_admin
  #   visit "/profiles/#{users(:admin_account).id}/edit"
  #   fill_in 'Avatar url', with: 'https://fake_url.com'
  #   # fill_in 'Picture', with: 'test_pic'
  #   click_on 'Save Changes'
  #   expect(page).to have_content 'https://fake_url.com'
  # end
  #
  # scenario 'non-admin user url' do
  #   login_as_user
  #   visit "/profiles/#{users(:user_account).id}/edit"
  #   fill_in 'Avatar url', with: 'https://fake_url.com'
  #   # fill_in 'Picture', with: 'test_pic'
  #   click_on 'Save Changes'
  #   expect(page).to have_content 'https://fake_url.com'
  # end
end

RSpec.describe 'Viewing a profile', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions, :fistbumps

  scenario 'user views own account' do
    login_as_user
    visit profiles_path(users(:user_account))

    expect(page).to have_content users(:user_account).full_name
  end

  scenario 'user views a different account' do
    login_as_user
    visit profiles_path(users(:account3))

    expect(page).to have_content users(:account3).full_name
  end

  scenario 'shows fistbumps given in the last month' do
    login_as_user
    visit profiles_path(users(:user_account))

    expect(page).to have_content '1 Fistbumps given in the last month'
  end

  scenario 'shows fistbumps recieved in the last month' do
    login_as_user
    visit profiles_path(users(:user_account))

    expect(page).to have_content '4 Fistbumps received in the last month'
  end
end
