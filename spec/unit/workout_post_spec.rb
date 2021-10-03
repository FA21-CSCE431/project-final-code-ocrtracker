# location spec/unit/workout_post_spec.rb
require 'rails_helper'

RSpec.describe WorkoutPost, type: :model do
  # Create a subject to test model validity with
  subject do
    FactoryBot.build(:workout_post)
  end

  # Ensure that the subject is valid with all fields
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  # Ensure that the subject is not valid without a title
  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).not_to be_valid
  end

  # Ensure that the subject is not valid without a date created
  it 'is not valid without a date created' do
    subject.date_created = nil
    expect(subject).not_to be_valid
  end
end
