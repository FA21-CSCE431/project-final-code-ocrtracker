# frozen_string_literal: true

# User
class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    return nil unless /@tamu.edu\z/.match?(email)

    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
  end
  # enum role: [:normal, :admin]
  has_many :workout_submissions, dependent: :destroy
  has_many :fistbumps, dependent: :destroy
  has_many :exercise_submissions, dependent: :destroy
end
