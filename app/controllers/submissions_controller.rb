class SubmissionsController < ApplicationController
    before_action :set_workout_post , only: %i[ new ]
    before_action :set_exercise_posts, only: %i[ new ]
  
    

    # GET 
    def index
      
    end
  
    # GET
    def show
    end
  
    # GET 
    def new
        @workout_submission = WorkoutSubmission.new
        @exercise_submission = ExerciseSubmission.new

    end
  
    # GET 
    def edit
    end
  
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
            unit_value: uv
          })
        end

        workout_submission.workout_post = @workout_post
        # @workout_submission = WorkoutSubmission.new(workout_submission_params)
        # @exercise_submissions = 
    
        respond_to do |format|
            if workout_submission.save 
              exercise_submissions.each(&:save!)
              format.html { redirect_to '/', notice: "Workout was successfully submitted" }
              # format.json { render :show, status: :created, location: workout_submission }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: workout_submission.errors, status: :unprocessable_entity }
            end
        end
    end
  
    # PATCH/PUT
    def update
      
    end
  
    # DELETE 
    def destroy
      
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
  