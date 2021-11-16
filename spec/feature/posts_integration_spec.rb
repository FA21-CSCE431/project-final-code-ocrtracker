# frozen_string_literal: true

# location: spec/feature/posts_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a workout post', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions

  scenario 'Create workout with one exercise' do
    login_as_admin
    visit '/posts/new'

    fill_in 'Title', with: 'new_post_title'

    select exercises(:pushups).title, from: 'workout_post_exercise_post_1_exercise_id'

    page.all(:fillable_field, 'Specific Instructions')[0].set('si1')

    page.find('#workout_post_exercise_post_1_is_ranked').set(true)

    click_on 'Create Workout post'

    expect(page).to have_content 'new_post_title'
  end

  scenario 'Fill in no fields' do
    login_as_admin
    visit '/posts/new'

    click_on 'Create Workout post'

    expect(page).to have_current_path posts_new_path, ignore_query: true
  end

  scenario 'non-admin user attempts to create a workout post', type: :feature do
    login_as_user
    visit '/posts/new'
    expect(page).to have_current_path root_path, ignore_query: true
  end
end
