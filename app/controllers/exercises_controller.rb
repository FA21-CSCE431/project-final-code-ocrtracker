class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[ show edit update destroy ]

  # GET /exercises
  def index
    @exercises = Exercise.all
  end

  # GET /exercises/1
  def show
  end

  # GET /exercises/new
  def new
    @exercise = Exercise.new
  end

  # GET /books/1/edit
  def edit
  end

  #POST /books
  def create
    @exercise = Exercise.new(exercise_params)

    respond_to do |format|
      if @exercise.save
        format.html {redirect_to @exercise, notice:"Exercise was successfully created"}
        format.json { render :show, status: :created, location: @exercise}
      else
        format.html {render :new, status: :unprocessable_entity}
        format.json { render json: @exercise.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /exercises/1
  def update
    respond_to do |format|
      if @exercise.update(exercise_params)
        format.html {redirect_to @exercise, notice:"Exercise was successfully updated"}
        format.json { render :show, status: :ok, location: @exercise}
      else
        format.html {render :edit, status: :unprocessable_entity}
        format.json { render json: @exercise.errors, status: :unprocessable_entity}
      end
    end
  end
  
  def destroy
    @exercise.destroy
    respond_to do |format|
      format.html {redirect_to exercise_url, notice: "Exercise was successfully destroyed"}
      format.json {head :no_content}
    end
  end

  private
    def set_exercise
      @exercise = Exercise.find(params[:id])
    end

    def exercise_params
      params.requrie(:exercise).permit(:title, :description, :picture, :unit_name)
    end
end