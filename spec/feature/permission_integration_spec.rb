# frozen_string_literal: true

# location: spec/feature/permission_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Editing permissions', type: :feature do
  fixtures :users

  scenario 'admin docs' do
    login_as_admin
    visit '/documentation'
    expect(page).to have_content 'for Admin'
  end

  scenario 'safegaurd docs' do
    login_as_safegaurd
    visit '/documentation'
    expect(page).to have_content 'for Admin'
  end

  scenario 'user docs' do
    login_as_user
    visit '/documentation'
    expect(page).to have_content 'for User'
  end

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

  scenario 'update multiple-mix' do
    login_as_admin
    visit '/permissions'
    page.uncheck("[user][#{users(:admin_account).id}][is_admin]")
    page.check("[user][#{users(:user_account).id}][is_admin]")
    click_on 'Save Changes'
    expect(page).to have_content 'Welcome'
  end

  scenario 'update multiple-mix3' do
    login_as_admin
    visit '/permissions'
    page.uncheck("[user][#{users(:admin_account).id}][is_admin]")
    page.check("[user][#{users(:user_account).id}][is_admin]")
    page.check("[user][#{users(:account3).id}][is_admin]")
    click_on 'Save Changes'
    expect(page).to have_content 'Welcome'
  end

  scenario 'update multiple-mix2' do
    login_as_admin
    visit '/permissions'
    page.check("[user][#{users(:user_account).id}][is_admin]")
    page.uncheck("[user][#{users(:account3).id}][is_admin]")
    click_on 'Save Changes'
    expect(page).to have_content 'Users successfully updated'
  end

  scenario 'testing safegaurd-rm' do
    login_as_safegaurd
    visit '/permissions'
    page.uncheck("[user][#{users(:admin_account).id}][is_admin]")
    page.uncheck("[user][#{users(:user_account).id}][is_admin]")
    click_on 'Save Changes'
    expect(page).to have_content 'Users successfully updated'
  end

  scenario 'testing safegaurd-give' do
    login_as_safegaurd
    visit '/permissions'
    page.check("[user][#{users(:admin_account).id}][is_admin]")
    page.check("[user][#{users(:user_account).id}][is_admin]")
    click_on 'Save Changes'
    expect(page).to have_content 'Users successfully updated'
  end

  scenario 'testing safegaurd-mix' do
    login_as_safegaurd
    visit '/permissions'
    page.check("[user][#{users(:admin_account).id}][is_admin]")
    page.uncheck("[user][#{users(:user_account).id}][is_admin]")
    page.check("[user][#{users(:account3).id}][is_admin]")
    click_on 'Save Changes'
    expect(page).to have_content 'Users successfully updated'
  end

  scenario 'permanent admin (tamuocr@gmail.com) is not displayed' do
    login_as_admin
    visit '/permissions'
    expect(page).not_to have_content 'tamuocr@gmail.com'
  end
end
