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
  has_many :profiles, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  def fistbumps_recieved_in_last_month
    count = 0
    exercise_submissions.each do |es|
      count += es.fistbumps.where('created_at > ?', 1.month.ago).count
    end
    count
  end

  def fistbumps_given_in_last_month
    fistbumps.where('created_at > ?', 1.month.ago).count
  end
end
