<<<<<<< HEAD
#location spec/unit/exercise_post_spec.rb
require 'rails_helper'

RSpec.describe ExercisePost, type: :model do

    # Create a subject to test model validity with
    # subject do
    #     described_class.new(
    #         exercise: FactoryBot.create(:exercise),
    #         workout_post: FactoryBot.create(:workout_post),
    #         specific_instructions: '50 pushups',
    #         is_ranked: true)
    # end

    # subject do
     #   e = FactoryBot.create(:exercise)
      #  wp = FactoryBot.create(:workout_post)
        # FactoryBot.create(:exercise_post)
      #  @subject = FactoryBot.create(:exercise_post, exercise: e, workout_post: wp)
    # end

    subject do
        FactoryBot.create(:exercise_post)
    end


    # subject = FactoryBot.create(:exercise)

    # Ensure that the subject is valid with all fields
    it 'is valid with valid attributes' do
        expect(subject).to be_valid
    end
    
    # Ensure that the subject is not valid without specific instructions
    it 'is not valid without specific instructions' do
        subject.specific_instructions = nil
        expect(subject).not_to be_valid
    end
    
end
=======
# frozen_string_literal: true

# location spec/unit/exercise_post_spec.rb
require 'rails_helper'

RSpec.describe ExercisePost, type: :model do
  # Create a subject to test model validity with
  # subject do
  #     described_class.new(
  #         exercise: FactoryBot.create(:exercise),
  #         workout_post: FactoryBot.create(:workout_post),
  #         specific_instructions: '50 pushups',
  #         is_ranked: true)
  # end

  # subject do
  #   e = FactoryBot.create(:exercise)
  #  wp = FactoryBot.create(:workout_post)
  # FactoryBot.create(:exercise_post)
  #  @subject = FactoryBot.create(:exercise_post, exercise: e, workout_post: wp)
  # end

  subject(:exercise_post) do
    FactoryBot.create(:exercise_post)
  end

  # subject = FactoryBot.create(:exercise)

  # Ensure that the subject is valid with all fields
  it 'is valid with valid attributes' do
    expect(exercise_post).to be_valid
  end

  # Ensure that the subject is not valid without specific instructions
  it 'is not valid without specific instructions' do
    exercise_post.specific_instructions = nil
    expect(exercise_post).not_to be_valid
  end
end
>>>>>>> 9645f30515eed86ee65f4943cf8cf17dbfec771b
