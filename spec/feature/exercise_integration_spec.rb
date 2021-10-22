# frozen_string_literal: true

# location: spec/feature/exercise_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating an exercise', type: :feature do
  fixtures :users

  scenario 'valid title' do
    login_as_admin
    visit exercises_path
    click_on 'New Exercise'
    fill_in 'Title', with: 'test_title'
    fill_in 'Description', with: 'test_desc'
    # fill_in 'Picture', with: 'test_pic'
    fill_in 'Unit name', with: 'test_un'
    click_on 'Create Exercise'
    expect(page).to have_content('test_title')
  end

  scenario 'valid description' do
    login_as_admin
    visit exercises_path
    click_on 'New Exercise'
    fill_in 'Title', with: 'test_title'
    fill_in 'Description', with: 'test_desc'
    # fill_in 'Picture', with: 'test_pic'
    fill_in 'Unit name', with: 'test_un'
    click_on 'Create Exercise'
    expect(page).to have_content('test_desc')
  end

  scenario 'valid unit name' do
    login_as_admin
    visit exercises_path
    click_on 'New Exercise'
    fill_in 'Title', with: 'test_title'
    fill_in 'Description', with: 'test_desc'
    # fill_in 'Picture', with: 'test_pic'
    fill_in 'Unit name', with: 'test_un'
    click_on 'Create Exercise'
    expect(page).to have_content('test_un')
  end

  scenario 'non-admin user' do
    login_as_user
    visit exercises_path
    expect(page.current_path).to eq root_path
  end

  scenario 'invalid inputs' do
    login_as_admin
    visit exercises_path
    click_on 'New Exercise'
    # fill_in 'Title', with: 'test_title'
    # fill_in 'Description', with: 'test_desc'
    # fill_in 'Picture', with: 'test_pic'
    # fill_in 'Unit name', with: 'test_un'
    click_on 'Create Exercise'
    expect(page).to have_content('error')
  end
end

RSpec.describe 'Editing an exercise', type: :feature do
  fixtures :users, :exercises

  scenario 'valid inputs' do
    login_as_admin
    visit edit_exercise_path(exercises(:pushups))
    fill_in 'Title', with: 'new_test_title'
    fill_in 'Description', with: 'new_test_desc'
    # fill_in 'Picture', with: 'test_pic'
    fill_in 'Unit name', with: 'new_test_un'
    click_on 'Update Exercise'
    expect(page).to have_content 'Exercise was successfully updated'
  end

  scenario 'invalid inputs' do
    login_as_admin
    visit edit_exercise_path(exercises(:pushups))
    fill_in 'Title', with: ''
    click_on 'Update Exercise'
    expect(page).to have_content 'error'
  end

  scenario 'non-admin user' do
    login_as_user
    visit edit_exercise_path(exercises(:pushups))
    expect(page.current_path).to eq root_path
  end
end

RSpec.describe 'Viewing an exercise', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts

  scenario 'through /exercises' do
    login_as_admin
    visit exercises_path
    expect(page).to have_content exercises(:pushups).title
  end

  scenario 'non-admin through /exercises' do
    login_as_user
    visit exercises_path
    expect(page.current_path).to eq root_path
  end

  scenario 'through /exercises/:id' do
    login_as_admin
    visit exercise_path(exercises(:pushups))
    expect(page).to have_content exercises(:pushups).title
  end

  scenario 'non-admin through /exercises/:id' do
    login_as_user
    visit exercise_path(exercises(:pushups))
    expect(page.current_path).to eq root_path
  end

  scenario 'non-admin through /submissions/new/:workout_post_id' do
    login_as_user
    visit "/submissions/new/#{workout_posts(:wp1).id}"
    expect(page).to have_content exercises(:pushups).title
  end
end
