# frozen_string_literal: true

# location: spec/feature/wod_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Admin wod view', type: :feature do
  fixtures :users, :exercises, :workout_posts

  scenario 'Admin views the current WOD date for a workout post' do
    login_as_admin
    visit set_wod_path

    expect(page).to have_field(workout_posts(:wp1).title, with: workout_posts(:wp1).wod_date.strftime('%FT%T'))
  end

  scenario 'Admin adds a WOD date to a workout post' do
    login_as_admin
    visit set_wod_path

    timestring = '2021-10-12T00:00:00'

    fill_in workout_posts(:wp2).title, with: timestring
    click_on 'Set WOD dates'

    expect(page).to have_field(workout_posts(:wp2).title, with: timestring)
  end

  scenario 'Admin updates an existing WOD date on a workout post' do
    login_as_admin
    visit set_wod_path

    timestring = '2020-10-12T00:00:00'

    fill_in workout_posts(:wp1).title, with: timestring
    click_on 'Set WOD dates'

    expect(page).to have_field(workout_posts(:wp1).title, with: timestring)
  end

  scenario 'Admin clears a WOD date from a workout post' do
    login_as_admin
    visit set_wod_path

    # The default capybara driver does not support javascript
    # click_on "clear_button_#{workout_posts(:wp1).id}"
    # Instead, fill in the field with an empty string, but that's what the button does
    fill_in workout_posts(:wp1).title, with: ''

    click_on 'Set WOD dates'

    expect(find_field(workout_posts(:wp1).title).value).to be_blank
  end

  scenario 'Admin changes a datetime input value to something funky' do
    login_as_admin
    visit set_wod_path

    fill_in workout_posts(:wp1).title, with: 'Something funky'

    click_on 'Set WOD dates'

    expect(find_field(workout_posts(:wp1).title).value).to be_blank
  end

  scenario 'non-admin user attempts to access /wod/set' do
    login_as_user
    visit set_wod_path
    expect(page.current_path).to eq root_path
  end
end

RSpec.describe 'User wod view', type: :feature do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions

  scenario 'User sees link to the current WOD' do
    login_as_user
    visit user_wod_path
    expect(page).to have_link(nil, href: new_submission_path(workout_posts(:wp2)))
  end

  scenario 'User cannot see future WOD' do
    login_as_user
    visit user_wod_path
    expect(page).not_to have_content workout_posts(:wp_with_wod_in_future).title
  end

  scenario 'User sees submission info for past WODs' do
    login_as_user
    visit user_wod_path
    expect(page).to have_content users(:user_account).workout_submissions.first.exercise_submissions.first.unit_value
  end
end
