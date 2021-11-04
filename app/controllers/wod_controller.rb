# frozen_string_literal: true

# WOD Controller
class WodController < ApplicationController
  before_action :set_recent_workout_posts, only: %i[admin_view]
  before_action :require_admin, only: %i[admin_view update_wod]
  before_action :set_all_current_or_past_wps_with_wod_dates, only: %i[user_view]

  # GET /wod/set
  def admin_view; end

  # POST /wod/set
  def update_wod
    submitted_hash = params[:workout_post]

    respond_to do |format|
      if WorkoutPost.update(submitted_hash.keys, submitted_hash.values.map { |x| { wod_date: x[:wod_date] } })
        format.html { redirect_to set_wod_path, notice: 'WOD dates successfully updated' }
      else
        format.html { redirect_to set_wod_path, notice: 'Failure' }
      end
    end
  end

  # GET /wod
  def user_view; end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_recent_workout_posts
    @workout_posts = WorkoutPost.recent_workout_posts
    
  end

  def set_all_current_or_past_wps_with_wod_dates
    @workout_posts = WorkoutPost.current_or_past_wod
    @current_submission = WorkoutSubmission.where(user_id: current_user.id, workout_post_id: WorkoutPost.current_wod);
  end
end
