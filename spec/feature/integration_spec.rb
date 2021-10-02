# location: spec/feature/integration_spec.rb
require 'rails_helper'


feature 'testing oauth' do
    fixtures :users
    scenario 'should create a new user' do
        visit user_google_oauth2_omniauth_authorize_path
        expect(page).to have_content('Successfully authenticated from Google account')
    end
end


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
        expect(page).to have_content "You must be an admin to access this section"
    end

end