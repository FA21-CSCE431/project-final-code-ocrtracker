# frozen_string_literal: true

# location spec/unit/exercise_submission_spec.rb
require 'rails_helper'

RSpec.describe ExerciseSubmission, type: :model do
  # Create a subject to test model validity with
  subject(:exercise_submission) do
    FactoryBot.build(:exercise_submission)
  end

  # Ensure that the subject is valid with all fields
  it 'is valid with valid attributes' do
    expect(exercise_submission).to be_valid
  end

  # Ensure that the subject is not valid without a unit value
  it 'is not valid without a unit value' do
    exercise_submission.unit_value = nil
    expect(exercise_submission).not_to be_valid
  end
end
