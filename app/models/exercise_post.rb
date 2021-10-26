# frozen_string_literal: true

class ExercisePost < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout_post
  has_many :exercise_submissions, dependent: :destroy
  validates :specific_instructions, presence: true

  def submissions_where_not_opted_out
    if exercise.unit_name == 'time_l_to_h'
      exercise_submissions.where(opt_out: false).order('unit_value::float ASC')
    else
      exercise_submissions.where(opt_out: false).order('unit_value::float DESC')
    end
  end
end
