# frozen_string_literal: true

# location: spec/feature/wod_integration_spec.rb
require 'rails_helper'

RSpec.describe '', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions

  # scenario '' do#, js: true do
  #   Capybara.current_driver = :selenium_chrome_headless
  #   login_as_admin
  #   visit set_wod_path
  #   fill_in 'wod_history_wod_date', with: '2021-10-01T00:00:00'
  #   click_on 'Set WOD date'


  #   expect(page).to have_content 'Successfully updated'
  # end

  scenario 'non-admin user attempts to access /wod/set' do
    login_as_user
    visit set_wod_path
    expect(page).to have_content 'You must be an admin to access this section'
  end

end