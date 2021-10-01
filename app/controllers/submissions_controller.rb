class SubmissionsController < ApplicationController
    before_action :set_workout_post #, only: %i[ show edit update destroy ]
    before_action :set_exercise_posts #, only: %i[ show edit update destroy ]
  
    

    # GET /ocrtrackers or /ocrtrackers.json
    def index
      
    end
  
    # GET /ocrtrackers/1 or /ocrtrackers/1.json
    def show
    end
  
    # GET 
    def new
        @workout_submission = WorkoutSubmission.new
        @exercise_submission = ExerciseSubmission.new


    end
  
    # GET /ocrtrackers/1/edit
    def edit
    end
  
    # POST 
    def create
        @workout_submission = WorkoutSubmission.new(workout_submission_params)
        @exercise_submissions = 
    
        respond_to do |format|
            if @workout_submission.save
            format.html { redirect_to @workout_submission, notice: "Ocrtracker was successfully created." }
            format.json { render :show, status: :created, location: @workout_submission }
            else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @workout_submission.errors, status: :unprocessable_entity }
            end
        end
    end
  
    # PATCH/PUT /ocrtrackers/1 or /ocrtrackers/1.json
    def update
      respond_to do |format|
        if @ocrtracker.update(ocrtracker_params)
          format.html { redirect_to @ocrtracker, notice: "Ocrtracker was successfully updated." }
          format.json { render :show, status: :ok, location: @ocrtracker }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @ocrtracker.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /ocrtrackers/1 or /ocrtrackers/1.json
    def destroy
      @ocrtracker.destroy
      respond_to do |format|
        format.html { redirect_to ocrtrackers_url, notice: "Ocrtracker was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout_post
    @workout_post = WorkoutPost.find(params[:workout_post_id])
    end

    def set_exercise_posts
    @exercise_posts = @workout_post.exercise_posts
    end

    def workout_submission_params
    params.require(:workout_submission).permit(:submitted_datetime, :workout_post_id, :user_id)
    end
    
    def exercise_submission_params
        params.require(:exercise_submission).permit(:exercise_post_id, :workout_submission_id, :unit_value)
    end


    #   # Only allow a list of trusted parameters through.
    #   def ocrtracker_params
    #     params.require(:ocrtracker).permit(:W.I.P)
    #   end
  end
  