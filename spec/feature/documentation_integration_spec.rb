# frozen_string_literal: true

# location: spec/feature/documentation_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Documentation', type: :feature do
  fixtures :users

  scenario 'non-admin user can see documentation for user' do
    login_as_user
    visit '/documentation'
    expect(page).to have_content 'Documentation for User'
  end

  scenario 'admin can see documentation for admin' do
    login_as_admin
    visit '/documentation'
    expect(page).to have_content 'Documentation for Admin'
  end
end
