# frozen_string_literal: true

# Dashboards Controller
class DashboardsController < ApplicationController
  before_action :set_ranked_eps, only: %i[leaderboard]

  def show; end

  def leaderboard; end

  def like
    @post = ExerciseSubmission.find(params[:exercise_submission_id])
    @post.liked_by current_user

    respond_to do |format|
      format.html { redirect_to '/leaderboard' }
    end
  end

  def unlike
    @post = ExerciseSubmission.find(params[:exercise_submission_id])
    @post.unliked_by current_user
    
    respond_to do |format|
      format.html { redirect_to '/leaderboard' }
    end
  end

  private

  def set_ranked_eps
    @current_wod = WorkoutPost.current_wod
    if @current_wod.is_a?(WorkoutPost)
      @ranked_eps = @current_wod.ranked_exercise_posts
    else
      @ranked_eps = []
      @current_wod = WorkoutPost.new
    end
  end
end
