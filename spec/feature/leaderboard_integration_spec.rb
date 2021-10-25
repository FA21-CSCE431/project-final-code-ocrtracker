# frozen_string_literal: true

# location: spec/feature/leaderboard_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Viewing the leaderboard', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions

  scenario 'leaderboard shows the correct workout post' do
    login_as_user
    visit '/leaderboard'

    expect(page).to have_content workout_posts(:wp2).title
  end

  scenario 'leaderboard shows ranked exercise posts' do
    login_as_user
    visit '/leaderboard'

    expect(page).to have_content 'Pushups'
  end

  scenario 'leaderboard does not show unranked exercise posts' do
    login_as_user
    visit '/leaderboard'

    expect(page).not_to have_content 'situps'
  end
end
