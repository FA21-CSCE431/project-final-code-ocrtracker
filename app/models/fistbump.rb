# frozen_string_literal: true

class Fistbump < ApplicationRecord
  belongs_to :user
  belongs_to :exercise_submission

  def self.liked?(user, exercise_submission)
    Fistbump.where(user: user, exercise_submission: exercise_submission).any?
  end
end
