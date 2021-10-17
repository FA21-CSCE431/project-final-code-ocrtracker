# frozen_string_literal: true

# location spec/unit/workout_post_spec.rb
require 'rails_helper'

RSpec.describe WorkoutPost, type: :model do
  # Create a subject to test model validity with
  subject(:workout_post) do
    FactoryBot.build(:workout_post)
  end

  # Ensure that the subject is valid with all fields
  it 'is valid with valid attributes' do
    expect(workout_post).to be_valid
  end

  # Ensure that the subject is not valid without a title
  it 'is not valid without a title' do
    workout_post.title = nil
    expect(workout_post).not_to be_valid
  end
end
