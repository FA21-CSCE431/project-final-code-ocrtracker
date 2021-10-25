# frozen_string_literal: true

# location spec/unit/exercise_post_spec.rb
require 'rails_helper'

RSpec.describe ExercisePost, type: :model do
  fixtures :users, :exercises, :workout_posts, :exercise_posts, :workout_submissions, :exercise_submissions, :fistbumps

  subject(:exercise_post) do
    FactoryBot.create(:exercise_post)
  end

  # Ensure that the subject is valid with all fields
  it 'is valid with valid attributes' do
    expect(exercise_post).to be_valid
  end

  # Ensure that the subject is not valid without specific instructions
  it 'is not valid without specific instructions' do
    exercise_post.specific_instructions = nil
    expect(exercise_post).not_to be_valid
  end

  context 'with submissions_where_not_opted_out' do
    it 'omits opted_out submissions' do
      expect(exercise_posts(:ep4).submissions_where_not_opted_out).not_to include(exercise_submissions(:es9))
    end

    it 'sorts pushups descending' do
      expect(exercise_posts(:ep4).submissions_where_not_opted_out.first).to eq(exercise_submissions(:es7))
    end

    it 'sorts situps ascending' do
      expect(exercise_posts(:ep3).submissions_where_not_opted_out.first).to eq(exercise_submissions(:es3))
    end
  end
end
