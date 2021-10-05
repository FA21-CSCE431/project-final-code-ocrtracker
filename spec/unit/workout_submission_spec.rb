# frozen_string_literal: true

# location spec/unit/workout_submission_spec.rb
require 'rails_helper'

RSpec.describe WorkoutSubmission, type: :model do
  # Create a subject to test model validity with
  subject do
    FactoryBot.create(:workout_submission)
  end

  # Ensure that the subject is valid with all fields
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  # Ensure that the subject is not valid without a submitted datetime
  it 'is not valid without a submitted datetime' do
    subject.submitted_datetime = nil
    expect(subject).not_to be_valid
  end
end
