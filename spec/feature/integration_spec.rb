# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Submitting a workout', type: :feature do
  # Include all of the current test fixtures
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions

  scenario 'user goes to the new submission page' do
    login_as_user

    # i.e. /submissions/new/5
    visit "/submissions/new/#{workout_posts(:wp1).id}"

    # Expect the page to have the title of the workout post
    expect(page).to have_content(workout_posts(:wp1).title.to_s)
  end
end
