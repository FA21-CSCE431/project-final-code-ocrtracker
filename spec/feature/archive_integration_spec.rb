# frozen_string_literal: true

# location: spec/feature/archive_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Archiving a user', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions

  scenario 'User does not show up on permissions page any more' do
    login_as_admin
    visit permissions_path
    click_link(href: archive_user_path(users(:user_account)))
    expect(page).not_to have_content users(:user_account).full_name
  end

  scenario 'User does not show up on members page' do
    login_as_admin
    visit permissions_path
    click_link(href: archive_user_path(users(:user_account)))
    visit members_path
    expect(page).not_to have_content users(:user_account).full_name
  end

  scenario 'User shows up on archived users page' do
    login_as_admin
    visit permissions_path
    click_link(href: archive_user_path(users(:user_account)))
    visit archived_profiles_path
    expect(page).to have_content users(:user_account).full_name
  end

  scenario 'Total workouts completed does not change' do
    login_as_admin

    total_workouts_completed = workout_submissions.count
    visit permissions_path
    click_link(href: archive_user_path(users(:user_account)))
    visit root_path

    expect(page).to have_content total_workouts_completed
  end

  scenario 'User\'s submissions do not show up in workout history' do
    login_as_admin
    visit permissions_path
    click_link(href: archive_user_path(users(:user_account)))
    visit submissions_history_path(workout_posts(:wp2))
    expect(page).not_to have_content users(:user_account).full_name
  end

  scenario 'User\'s submissions do not show up in leaderboard' do
    login_as_admin
    visit permissions_path
    click_link(href: archive_user_path(users(:user_account)))
    visit leaderboard_path
    expect(page).not_to have_content users(:user_account).full_name
  end

  scenario 'Archived user cannot sign in' do
    login_as_admin
    visit permissions_path
    click_link(href: archive_user_path(users(:user_account)))
    # sign_out_all_scopes
    sign_out users(:admin_account)
    OmniAuth.config.mock_auth[:google_oauth2].info.email = users(:user_account).email

    visit '/'
    click_on 'Sign in with Google'
    expect(page).to have_content 'has been archived'
  end
end

RSpec.describe 'Restoring a user', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions

  before do
    users(:user_account).archive
  end

  scenario 'User shows up on permissions page' do
    login_as_admin
    visit archived_profiles_path
    click_link(href: restore_user_path(users(:user_account)))
    visit permissions_path
    expect(page).to have_content users(:user_account).full_name
  end

  scenario 'User shows up on members page' do
    login_as_admin
    visit archived_profiles_path
    click_link(href: restore_user_path(users(:user_account)))
    visit members_path
    expect(page).to have_content users(:user_account).full_name
  end

  scenario 'User does not show up on archived users page' do
    login_as_admin
    visit archived_profiles_path
    click_link(href: restore_user_path(users(:user_account)))
    visit archived_profiles_path
    expect(page).not_to have_content users(:user_account).full_name
  end

  scenario 'User\'s submissions show up in workout history' do
    login_as_admin
    visit archived_profiles_path
    click_link(href: restore_user_path(users(:user_account)))
    visit submissions_history_path(workout_posts(:wp2))
    expect(page).to have_content users(:user_account).full_name
  end

  scenario 'User\'s submissions show up in leaderboard' do
    login_as_admin
    visit archived_profiles_path
    click_link(href: restore_user_path(users(:user_account)))
    visit leaderboard_path
    expect(page).to have_content users(:user_account).full_name
  end
end

RSpec.describe 'Archiving an exercise', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions

  scenario 'Exercise does not show up on exercises page any more' do
    login_as_admin
    pushups = exercises(:pushups)
    visit edit_exercise_path(pushups)
    click_on 'Archive Exercise'
    visit exercises_path
    expect(page).not_to have_content pushups.title
  end

  scenario 'Exercise shows up on archived exercises page' do
    login_as_admin
    pushups = exercises(:pushups)
    visit edit_exercise_path(pushups)
    click_on 'Archive Exercise'
    visit archived_exercises_path
    expect(page).to have_content pushups.title
  end

  scenario 'Exercise still shows up on leaderboard' do
    login_as_admin
    pushups = exercises(:pushups)
    visit edit_exercise_path(pushups)
    click_on 'Archive Exercise'
    visit leaderboard_path
    expect(page).to have_content pushups.title
  end

  scenario 'Exercise still shows up on submission page' do
    login_as_admin
    pushups = exercises(:pushups)
    visit edit_exercise_path(pushups)
    click_on 'Archive Exercise'
    visit new_submission_path(workout_posts(:wp2))
    expect(page).to have_content pushups.title
  end
end

RSpec.describe 'Restoring an exercise', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions

  before do
    exercises(:pushups).archive
  end

  scenario 'Exercise shows up on exercises page' do
    login_as_admin
    pushups = exercises(:pushups)
    visit archived_exercises_path
    click_link(href: restore_exercise_path(pushups))
    visit exercises_path
    expect(page).to have_content pushups.title
  end

  scenario 'Exercise dooes not show up on archived exercises page' do
    login_as_admin
    pushups = exercises(:pushups)
    visit archived_exercises_path
    click_link(href: restore_exercise_path(pushups))
    visit archived_exercises_path
    expect(page).not_to have_content pushups.title
  end
end
