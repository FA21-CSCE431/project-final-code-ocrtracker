# frozen_string_literal: true

class Fistbump < ApplicationRecord
  belongs_to :user
  belongs_to :exercise_submission
end
