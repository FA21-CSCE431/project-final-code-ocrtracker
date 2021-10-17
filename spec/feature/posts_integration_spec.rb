# frozen_string_literal: true

# location: spec/feature/posts_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a workout post', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions

  scenario 'Create workout with two exercises' do
    login_as_admin
    visit '/posts/new'

    fill_in 'Title', with: 'title'

    select exercises(:pushups).title, from: 'workout_post_exercise_post_1_exercise_id'
    select exercises(:situps).title, from: 'workout_post_exercise_post_2_exercise_id'

    page.all(:fillable_field, 'Specific instructions')[0].set('si1')
    page.all(:fillable_field, 'Specific instructions')[1].set('si2')

    page.find('#workout_post_exercise_post_1_is_ranked').set(true)
    page.find('#workout_post_exercise_post_2_is_ranked').set(false)

    click_on 'Create Workout post'

    expect(page).to have_content('Workout was successfully posted')
  end

  scenario 'Fill in no fields' do
    login_as_admin
    visit '/posts/new'

    click_on 'Create Workout post'

    expect(page).to have_content('Error: Could not post workout')
  end

  scenario 'non-admin user attempts to create a workout post', type: :feature do
    login_as_user
    visit '/posts/new'
    expect(page).to have_content 'You must be an admin to access this section'
  end
end
