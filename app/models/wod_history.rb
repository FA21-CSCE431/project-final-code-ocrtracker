# frozen_string_literal: true

class WodHistory < ApplicationRecord
  belongs_to :workout_post
end
