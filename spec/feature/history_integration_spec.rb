# frozen_string_literal: true

# location: spec/feature/history_integration_spec.rb
require 'rails_helper'

RSpec.describe 'View submission history for a workout post', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions

  scenario 'admin views submission history for a workout post' do
    login_as_admin

    # Set a workout post
    wp = workout_posts(:wp1)

    visit "/submissions/history/#{wp.id}"
    expect(page).to have_content(wp.ranked_exercise_post.exercise_submissions.first.humanized_unit_value)
  end

  scenario 'user visits history path' do
    login_as_user

    wp = workout_posts(:wp1)
    visit "/submissions/history/#{wp.id}"
    expect(page).to have_content('You must be an admin to access this section')
  end
end
