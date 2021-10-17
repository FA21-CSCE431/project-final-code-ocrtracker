# frozen_string_literal: true

# location spec/unit/exercise_submission_spec.rb
require 'rails_helper'

RSpec.describe ExerciseSubmission, type: :model do
  # Create a subject to test model validity with
  subject do
    FactoryBot.build(:exercise_submission)
  end

  # Ensure that the subject is valid with all fields
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  # Ensure that the subject is not valid without a unit value
  it 'is not valid without a unit value' do
    subject.unit_value = nil
    expect(subject).not_to be_valid
  end
end
