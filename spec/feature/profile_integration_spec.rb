# frozen_string_literal: true

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
