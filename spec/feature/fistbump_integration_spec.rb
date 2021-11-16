# frozen_string_literal: true

# location: spec/feature/fistbump_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Fistbumps', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions, :fistbumps

  scenario 'fistbump a submission' do
    login_as_user
    visit '/leaderboard'
    find("a[href='/leaderboard/like/#{exercise_submissions(:es4).id}']").click
    expect(page).to have_content '2'
  end

  scenario 'remove a fistbump from a submission' do
    login_as_admin
    visit '/leaderboard'
    find("a[href='/leaderboard/unlike/#{exercise_submissions(:es4).id}']").click
    expect(page).to have_content '0'
  end

  scenario 'cannot fistbump a submission twice' do
    login_as_admin
    visit '/leaderboard'
    expect(page).not_to have_link_helper("/leaderboard/like/#{exercise_submissions(:es4).id}")
  end

  scenario 'cannot un-fistbump a submission twice' do
    login_as_user
    visit '/leaderboard'
    expect(page).not_to have_link_helper("/leaderboard/unlike/#{exercise_submissions(:es4).id}")
  end
end
