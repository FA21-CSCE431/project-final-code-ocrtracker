# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users, type: :model do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions, :fistbumps

  # Create a subject to test model validity with
  subject(:user) do
    FactoryBot.create(:user)
  end

  # Ensure that the subject is valid with all fields
  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  # Ensure that the subject is not valid without a submitted datetime
  it 'is valid with no description' do
    user.description = nil
    expect(user).to be_valid
  end

  it 'only counts fistbumps recieved from the last month' do
    # Original = 3, add 1 from 2 months ago and 1 from 10 days ago, expect 4
    users(:account3).fistbumps.create([{ exercise_submission: exercise_submissions(:es2), created_at: Time.current - 2.months },
                                       { exercise_submission: exercise_submissions(:es4), created_at: Time.current - 10.days }])
    expect(users(:user_account).fistbumps_recieved_in_last_month).to eq(4)
  end

  it 'only counts fistbumps given in the last month' do
    # Original = 1, add 1 from 2 months ago and 1 from 10 days ago, expect 2
    users(:user_account).fistbumps.create([{ exercise_submission: exercise_submissions(:es7), created_at: Time.current - 2.months },
                                           { exercise_submission: exercise_submissions(:es8), created_at: Time.current - 10.days }])
    expect(users(:user_account).fistbumps_given_in_last_month).to eq(2)
  end
end
