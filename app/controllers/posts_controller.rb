# frozen_string_literal: true

# Posts Controller
class PostsController < ApplicationController
  before_action :set_exercises, only: %i[new create edit update archive]

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
  def edit
    @workout_post = WorkoutPost.find(params[:workout_post_id])
  end

  # POST
  def create
    workout_post = WorkoutPost.new(title: params[:title])

    submitted_exercise_posts = params[:exercise_post]

    workout_post.exercise_posts.build(submitted_exercise_posts.values)

    respond_to do |format|
      if workout_post.save
        format.html { redirect_to submissions_history_path(workout_post.id), notice: 'Workout was successfully posted' }
        # format.json { render :show, status: :created, location: workout_submission }
      else
        format.html { redirect_to posts_new_path, notice: 'Error: Could not post workout' }
        # format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT
  def update
    workout_post = WorkoutPost.find(params[:workout_post_id])
    submitted_exercise_posts = params[:exercise_post]
    respond_to do |format|
      # If the workout submission and all exercise submissions are valid
      if submitted_exercise_posts.values.all? { |v| v[:exercise_id] }
        # If any of the previous exercise posts were deleted
        delete_exercises(workout_post, submitted_exercise_posts)
        submitted_exercise_posts.each { |key, v| edit_or_add_exercise(workout_post, key, v) }
        workout_post.update(title: params[:title])
        format.html { redirect_to '/wod/set', notice: 'Workout was successfully edited' }
      else
        format.html { redirect_to edit_post_url(params[:workout_post_id]), notice: 'Workout was not valid' }
      end
    end
  end

  def archive
    post = WorkoutPost.find(params[:workout_post_id])
    post.archived = true
    respond_to do |format|
      if post.save
        format.html { redirect_to '/wod/set', notice: 'Post archived successfully' }
      else
        format.html { redirect_to '/wod/set', notice: 'Post could not be archived' }
      end
    end
  end

  # DELETE
  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exercises
    @exercises = Exercise.not_archived
  end
end

def delete_exercises(workout_post, submitted_posts)
  workout_post.exercise_posts.each do |post|
    post.destroy if submitted_posts.key?(post.id) == false
  end
end

def edit_or_add_exercise(workout_post, key, val)
  # If the exercise post already existed
  if ExercisePost.exists?(id: key)
    ExercisePost.update(key, exercise_id: val[:exercise_id], specific_instructions: val[:specific_instructions], is_ranked: val[:is_ranked])
  # If the exercise post was added
  else
    workout_post.exercise_posts.create(exercise_id: val[:exercise_id], specific_instructions: val[:specific_instructions], is_ranked: val[:is_ranked])
  end
end
