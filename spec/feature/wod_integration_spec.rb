# frozen_string_literal: true

# location: spec/feature/wod_integration_spec.rb
require 'rails_helper'

RSpec.describe '', type: :feature do
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
    expect(page).to have_content 'You must be an admin to access this section'
  end
end
