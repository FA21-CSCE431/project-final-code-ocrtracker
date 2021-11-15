# frozen_string_literal: true

# location: spec/feature/submission_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Viewing a workout post', type: :feature do
  # Include all of the current test fixtures
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions

  scenario 'user can view workout information before they submit' do
    login_as_user

    # i.e. /submissions/new/5
    visit "/submissions/new/#{workout_posts(:wp1).id}"

    # Expect the page to have the title of the workout post
    expect(page).to have_content(workout_posts(:wp1).title.to_s)
  end

  scenario 'user can view exercise information before they submit' do
    login_as_user

    visit "/submissions/new/#{workout_posts(:wp1).id}"

    # Expect the page to have the title of an exercise included in the workout post
    expect(page).to have_content(workout_posts(:wp1).exercise_posts.first.exercise.title)
  end

  scenario 'user can view exercise_post information before they submit' do
    login_as_user

    visit "/submissions/new/#{workout_posts(:wp1).id}"

    # Expect the page to have the specific instructions of an exercise post included in the workout post
    expect(page).to have_content(workout_posts(:wp1).exercise_posts.first.specific_instructions)
  end
end

RSpec.describe 'Submitting a new workout submission', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions

  # Sunny
  scenario 'user fills in all available fields' do
    login_as_admin

    wp = workout_posts(:wp1)

    visit "/submissions/new/#{wp.id}"

    # Fill in all entry boxes
    fill_in 'Minutes', with: '2'
    fill_in 'Seconds', with: '30'
    fill_in 'Number', with: '50'

    click_on 'Submit'
    expect(page).to have_current_path user_wod_path, ignore_query: true
  end

  # Rainy
  scenario 'user does not fill in any fields' do
    login_as_admin

    wp = workout_posts(:wp1)

    visit "/submissions/new/#{wp.id}"

    click_on 'Submit'

    expect(page).to have_current_path new_submission_url(wp.id), ignore_query: true
  end

  scenario 'user gets redirected to new if they do not have a submission' do
    login_as_admin
    wp = workout_posts(:wp1)
    visit "/submissions/edit/#{wp.id}"
    expect(page).to have_current_path "/submissions/new/#{wp.id}", ignore_query: true
  end
end

RSpec.describe 'Editing a workout submission', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions

  scenario 'user fills in all available fields' do
    login_as_admin

    wp = workout_posts(:wp1)

    visit "/submissions/edit/#{wp.id}"

    # Fill in all entry boxes
    fill_in 'Minutes', with: '2'
    fill_in 'Seconds', with: '30'
    fill_in 'Number', with: '50'

    click_on 'Submit'
    expect(page).to have_current_path user_wod_path, ignore_query: true
  end

  scenario 'user goes back to edit a workout submission' do
    login_as_user
    wp = workout_posts(:wp1)

    visit "/submissions/edit/#{wp.id}"
    expect(page).to have_content('Edit Workout Submission')
  end

  scenario 'user gets redirected to edit if they have a submission' do
    login_as_user
    wp = workout_posts(:wp1)

    visit "/submissions/new/#{wp.id}"
    expect(page).to have_current_path "/submissions/edit/#{wp.id}", ignore_query: true
  end
end

RSpec.describe 'viewing workout history', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions

  scenario 'admin wants to view workout history' do
    login_as_admin

    wp = workout_posts(:wp1)

    visit "/submissions/history/#{wp.id}"

    expect(page).to have_content 'Workout Post 1'
  end

  scenario 'future workout history' do
    login_as_admin

    wp = workout_posts(:wp_with_wod_in_future)

    visit "/submissions/history/#{wp.id}"

    expect(page).to have_content 'Workout Post 3 (WOD in future)'
  end

  scenario 'no workout history' do
    login_as_admin

    wp = workout_posts(:wp_with_no_submissions)

    visit "/submissions/history/#{wp.id}"

    expect(page).to have_content 'Workout Post 4 (no submissions)'
  end

  scenario 'user wants to view workout history' do
    login_as_user

    wp = workout_posts(:wp1)

    visit "/submissions/history/#{wp.id}"

    expect(page).to have_current_path root_path, ignore_query: true
  end

  scenario 'user no workout history' do
    login_as_user

    wp = workout_posts(:wp_with_no_submissions)

    visit "/submissions/history/#{wp.id}"

    expect(page).to have_current_path root_path, ignore_query: true
  end
end
