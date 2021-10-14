# frozen_string_literal: true

# Posts Controller
class WodController < ApplicationController
  before_action :set_recent_workout_posts, only: %i[index]
  before_action :require_admin # , only: %i[index update_wod remove]

  # GET /wod/set
  def index; end

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

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_recent_workout_posts
    # TODO: change this to show the last 10? Made within the last week?
    @workout_posts = WorkoutPost.limit(10).order('created_at DESC')
  end
end
