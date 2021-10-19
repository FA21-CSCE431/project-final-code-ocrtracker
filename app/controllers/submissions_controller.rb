# frozen_string_literal: true

# Submissions Controller
class SubmissionsController < ApplicationController
  before_action :set_workout_post, only: %i[new history]
  before_action :set_exercise_posts, only: %i[new]

  before_action :set_workout_submissions, only: %i[history]

  before_action :require_admin, only: %i[history]

  def history; end

  # GET
  def index; end

  # GET
  def show; end

  # GET
  def new
    @workout_submission = WorkoutSubmission.new
    @exercise_submission = ExerciseSubmission.new
  end

  # GET
  def edit; end

  # POST
  def create
    submissions = params[:exercise_submission]

    workout_submission = WorkoutSubmission.new({
                                                 user: current_user,
                                                 submitted_datetime: DateTime.now,
                                                 workout_post_id: params[:wp_id]
                                               })

    submissions.each do |ep_id, fields|
      uv = get_uv(fields)
      workout_submission.exercise_submissions.build({
                                                      exercise_post_id: ep_id,
                                                      unit_value: uv,
                                                      user: current_user
                                                    })
    end

    respond_to do |format|
      # If the workout submission and all exercise submissions are valid
      if workout_submission.save
        format.html { redirect_to '/', notice: 'Workout was successfully submitted' }
        # format.json { render :show, status: :created, location: workout_submission }
      else
        format.html { redirect_to new_submission_url(params[:wp_id]), status: :unprocessable_entity }
        format.json { render json: workout_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT
  def update; end

  # DELETE
  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_workout_post
    @workout_post = WorkoutPost.find(params[:workout_post_id])
  end

  def set_exercise_posts
    @exercise_posts = @workout_post.exercise_posts
  end

  def set_workout_submissions
    @workout_submissions = @workout_post.workout_submissions
  end

  # Check if a string represents a valid number
  def numeric?(field)
    !Float(field).nil?
  rescue StandardError
    false
  end

  # Get the unit value from the params, either as a single value or a combination of minutes and seconds
  def get_uv(fields)
    if numeric?(fields[:unit_value])
      fields[:unit_value]
    elsif numeric?(fields[:minutes]) && numeric?(fields[:seconds])
      (fields[:minutes].to_f * 60) + fields[:seconds].to_f
    end
  end
end
