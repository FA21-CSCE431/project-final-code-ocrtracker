# frozen_string_literal: true

# location spec/unit/workout_post_spec.rb
require 'rails_helper'

RSpec.describe WorkoutPost, type: :model do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions
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

  it 'gives the correct current_wod' do
    expect(described_class.current_wod).to eq(workout_posts(:wp2))
  end

  it 'does not give future wods' do
    expect(described_class.current_or_past_wod).not_to include(workout_posts(:wp_with_wod_in_future))
  end

  it 'does not give unranked exercise posts' do
    expect(workout_posts(:wp1).ranked_exercise_posts).not_to include(exercise_posts(:ep2))
  end

  it 'gives an empty list when asked for ES to the post for a user who has none' do
    expect(workout_posts(:wp1).exercise_submissions_to_this_post_for_current_user(users(:account3))).to eq([])
  end
end
