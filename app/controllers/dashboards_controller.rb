# frozen_string_literal: true

# Dashboards Controller
class DashboardsController < ApplicationController
  before_action :set_ranked_eps, only: %i[leaderboard]

  def show; end

  def leaderboard; end

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
