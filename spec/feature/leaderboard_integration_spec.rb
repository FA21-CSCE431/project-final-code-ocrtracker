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

  describe 'leaderboard shows ranked exercise posts' do
    it 'shows pushups' do
      login_as_user
      visit '/leaderboard'

      expect(page).to have_content 'Pushups'
    end

    it 'shows pullups' do
      login_as_user
      visit '/leaderboard'

      expect(page).to have_content 'Pullups'
    end
  end

  scenario 'leaderboard does not show unranked exercise posts' do
    login_as_user
    visit '/leaderboard'

    expect(page).not_to have_content 'Situps'
  end

  scenario 'No WOD, does not crash' do
    WorkoutPost.all.destroy_all
    login_as_user
    visit '/leaderboard'
    expect(page).to have_content 'Leaderboard'
  end

  scenario 'fistbump' do
    login_as_user
    visit '/leaderboard'
    expect(page).to have_content 'Fistbumps'
  end

  scenario 'admin leaderboard shows the correct workout post' do
    login_as_admin
    visit '/leaderboard'

    expect(page).to have_content workout_posts(:wp2).title
  end

  describe 'admin leaderboard shows ranked exercise posts' do
    it 'shows pushups' do
      login_as_admin
      visit '/leaderboard'

      expect(page).to have_content 'Pushups'
    end

    it 'admin shows pullups' do
      login_as_admin
      visit '/leaderboard'

      expect(page).to have_content 'Pullups'
    end
  end

  scenario 'admin leaderboard does not show unranked exercise posts' do
    login_as_admin
    visit '/leaderboard'

    expect(page).not_to have_content 'Situps'
  end

  scenario 'admin No WOD, does not crash' do
    WorkoutPost.all.destroy_all
    login_as_admin
    visit '/leaderboard'
    expect(page).to have_content 'Leaderboard'
  end

  scenario 'admin fistbump' do
    login_as_admin
    visit '/leaderboard'
    expect(page).to have_content 'Fistbumps'
  end
end
