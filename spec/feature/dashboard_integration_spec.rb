# frozen_string_literal: true

# location: spec/feature/fistbump_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Dashboard', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions

  scenario 'User can see the total workouts completed' do
    login_as_user
    visit '/'
    expect(page).to have_content workout_posts.count
  end

  scenario 'User can see their name on the dashboard' do
    login_as_user
    visit '/'
    expect(page).to have_content "Welcome, #{users(:user_account).full_name}"
  end
end
