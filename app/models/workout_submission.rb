# frozen_string_literal: true

# Workout Submission
class WorkoutSubmission < ApplicationRecord
  belongs_to :workout_post
  belongs_to :user
  has_many :exercise_submissions, dependent: :destroy

  validates :submitted_datetime, presence: true

  def humanized_submitted_datetime
    submitted_datetime.strftime('%B %d at %I:%M %p')
  end

  def self.trendline
    trendline = []
    (Time.zone.today - 4..Time.zone.today).each do |date|
      trendline << [date.strftime('%B %-d'), where(submitted_datetime: date.all_day).count]
    end
    trendline
  end
end
