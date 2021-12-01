# frozen_string_literal: true

# User
class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    return nil unless /@tamu.edu\z/.match?(email) || /tamuocr@gmail.com\z/.match?(email)

    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
  end

  default_scope { where(archived: [false, nil]) }

  scope :archived, lambda {
    unscoped.where(archived: true)
  }

  scope :not_permanent_admin, lambda {
    @users = User.where.not(email: 'tamuocr@gmail.com')
  }

  # has_many :workout_submissions, -> { unscope(where: :archived)} , dependent: :destroy
  has_many :workout_submissions, dependent: :destroy
  has_many :fistbumps, dependent: :destroy
  has_many :exercise_submissions, dependent: :destroy
  has_many :profiles, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }

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

  def workout_submissions_unscoped
    workout_submissions.unscope(where: :archived)
  end

  def archive
    update(archived: true)
    workout_submissions.update_all(archived: true)
  end

  def un_archive
    update(archived: false)
    workout_submissions_unscoped.update_all(archived: false)
  end
end
