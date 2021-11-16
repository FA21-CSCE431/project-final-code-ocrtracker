# frozen_string_literal: true

# location: spec/feature/members_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Viewing members', type: :feature do
  fixtures :users

  scenario 'members are displayed' do
    login_as_admin
    visit '/members'
    expect(page).to have_content 'user_email@tamu.edu'
  end

  scenario 'admins are displayed' do
    login_as_admin
    visit '/members'
    expect(page).to have_content 'admin_email@tamu.edu'
  end

  scenario 'user view-members are displayed' do
    login_as_user
    visit '/members'
    expect(page).to have_content 'user_email@tamu.edu'
  end

  scenario 'user view-admins are displayed' do
    login_as_user
    visit '/members'
    expect(page).to have_content 'admin_email@tamu.edu'
  end

  scenario 'members names are displayed' do
    login_as_admin
    visit '/members'
    expect(page).to have_content 'user account'
  end

  scenario 'admins names are displayed' do
    login_as_admin
    visit '/members'
    expect(page).to have_content 'admin account'
  end

  scenario 'user view-members names are displayed' do
    login_as_user
    visit '/members'
    expect(page).to have_content 'user account'
  end

  scenario 'user view-admins names are displayed' do
    login_as_user
    visit '/members'
    expect(page).to have_content 'admin account'
  end

  scenario 'permanent admin (tamuocr@gmail.com) is not displayed' do
    login_as_admin
    visit '/members'
    expect(page).not_to have_content 'tamuocr@gmail.com'
  end
end
