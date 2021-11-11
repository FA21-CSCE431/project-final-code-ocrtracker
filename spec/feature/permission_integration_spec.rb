# frozen_string_literal: true

# location: spec/feature/permission_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Editing permissions', type: :feature do
  fixtures :users

  scenario 'valid check' do
    login_as_admin
    visit '/permissions'
    page.check("[user][#{users(:admin_account).id}][is_admin]")
    click_on 'Save Changes'
    expect(page).to have_content 'Users successfully updated'
  end

  scenario 'valid uncheck' do
    login_as_admin
    visit '/permissions'
    page.uncheck("[user][#{users(:admin_account).id}][is_admin]")
    click_on 'Save Changes'
    expect(page).to have_content 'Welcome'
  end

  scenario 'non-admin user' do
    login_as_user
    visit '/permissions'
    expect(page).to have_current_path root_path, ignore_query: true
  end

  scenario 'update multiple-give' do
    login_as_admin
    visit '/permissions'
    page.check("[user][#{users(:admin_account).id}][is_admin]")
    page.check("[user][#{users(:user_account).id}][is_admin]")
    click_on 'Save Changes'
    expect(page).to have_content 'Users successfully updated'
  end

  scenario 'update multiple-remove' do
    login_as_admin
    visit '/permissions'
    page.uncheck("[user][#{users(:admin_account).id}][is_admin]")
    page.uncheck("[user][#{users(:user_account).id}][is_admin]")
    click_on 'Save Changes'
    expect(page).to have_content 'Welcome'
  end

  scenario 'permanent admin (tamuocr@gmail.com) is not displayed' do
    login_as_admin
    visit '/permissions'
    expect(page).not_to have_content 'tamuocr@gmail.com'
  end
end
