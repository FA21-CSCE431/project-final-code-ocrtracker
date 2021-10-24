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

RSpec.describe 'Submitting to a workout post', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts

  # Sunny
  scenario 'user fills in all available fields' do
    login_as_user

    wp = workout_posts(:wp1)

    visit "/submissions/new/#{wp.id}"

    # Fill in all entry boxes
    fill_in 'Minutes', with: '2'
    fill_in 'Seconds', with: '30'
    fill_in 'Number', with: '50'

    click_on 'Submit'
    expect(page).to have_current_path root_path, ignore_query: true
  end

  # Rainy
  scenario 'user does not fill in any fields' do
    login_as_user

    wp = workout_posts(:wp1)

    visit "/submissions/new/#{wp.id}"

    click_on 'Submit'

    expect(page).to have_current_path new_submission_url(wp.id), ignore_query: true
  end
end
