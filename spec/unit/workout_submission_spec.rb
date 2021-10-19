# frozen_string_literal: true

# location spec/unit/workout_submission_spec.rb
require 'rails_helper'

RSpec.describe WorkoutSubmission, type: :model do
  # Create a subject to test model validity with
  subject(:workout_submission) do
    FactoryBot.create(:workout_submission)
  end

  # Ensure that the subject is valid with all fields
  it 'is valid with valid attributes' do
    expect(workout_submission).to be_valid
  end

  # Ensure that the subject is not valid without a submitted datetime
  it 'is not valid without a submitted datetime' do
    workout_submission.submitted_datetime = nil
    expect(workout_submission).not_to be_valid
  end
end
