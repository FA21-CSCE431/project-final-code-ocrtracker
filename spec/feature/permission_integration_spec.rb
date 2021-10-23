# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Editing permissions', type: :feature do
  fixtures :users

  scenario 'valid check' do
    login_as_admin
    visit "/permissions"
    page.check("[user][#{users(:admin_account).id}][is_admin]")
    click_on 'Save Changes'
    expect(page).to have_content 'Users successfully updated'
  end

  scenario 'valid uncheck' do
    login_as_admin
    visit "/permissions"
    page.uncheck("[user][#{users(:admin_account).id}][is_admin]")
    click_on 'Save Changes'
    expect(page).to have_content 'Welcome to the User Dashboard!'
  end

  scenario 'non-admin user' do
    login_as_user
    visit "/permissions"
    expect(page).to have_content 'You must be an admin to access this section'
  end
end
