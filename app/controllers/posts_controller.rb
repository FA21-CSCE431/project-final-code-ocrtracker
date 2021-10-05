# frozen_string_literal: true

# Posts Controller
class PostsController < ApplicationController
  before_action :set_exercises, only: %i[new]

  before_action :set_workout_posts, only: %i[index]
  before_action :set_exercise_posts, only: %i[index]

  before_action :require_admin, only: %i[new create]

  # GET
  def index; end

  # GET
  def show; end

  # GET
  def new
    @workout_post = WorkoutPost.new
    @exercise_post = ExercisePost.new
  end

  # GET
  def edit; end

  # POST
  def create
    workout_post = WorkoutPost.new(title: params[:workout_post][:title], date_created: Date.today)

    submitted_exercise_posts = params[:workout_post][:exercise_post]

    workout_post.exercise_posts.build(submitted_exercise_posts.values)

    respond_to do |format|
      if workout_post.valid? && workout_post.exercise_posts.all?(&:valid?)
        workout_post.save
        workout_post.exercise_posts.each(&:save!)
        format.html { redirect_to '/', notice: 'Workout was successfully posted' }
        # format.json { render :show, status: :created, location: workout_submission }
      else
        format.html { redirect_to '/', notice: 'Error: Could not post workout' }
        # format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT
  def update; end

  # DELETE
  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exercises
    @exercises = Exercise.all
  end

  def exercise_post_params
    params.require(:exercise_post).permit(:exercise_id, :workout_post_id, :specific_instructions, :is_ranked)
  end
end
