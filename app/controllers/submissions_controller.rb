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
    exercise_submissions = []

    workout_submission = WorkoutSubmission.new({
                                                 user: current_user,
                                                 submitted_datetime: DateTime.now
                                               })

    submissions.each do |ep_id, uv|
      exercise_post = ExercisePost.find(ep_id)
      @workout_post = exercise_post.workout_post
      exercise_submissions << ExerciseSubmission.new({
                                                       exercise_post: exercise_post,
                                                       workout_submission: workout_submission,
                                                       unit_value: uv[:unit_value]
                                                     })
    end

    workout_submission.workout_post = @workout_post

    respond_to do |format|
      # If the workout submission and all exercise submissions are valid
      if workout_submission.valid? && exercise_submissions.all?(&:valid?)
        workout_submission.save
        exercise_submissions.each(&:save!)
        format.html { redirect_to '/', notice: 'Workout was successfully submitted' }
        # format.json { render :show, status: :created, location: workout_submission }
      else
        format.html { render :new, status: :unprocessable_entity }
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
end
