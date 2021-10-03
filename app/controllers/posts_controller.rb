class PostsController < ApplicationController
    before_action :set_exercises, only: %i[ new ]
    before_action :initialize_ep, only: %i[ new ]

    before_action :set_workout_posts, only: %i[ index ]
    before_action :set_exercise_posts, only: %i[ index ]
    

    # GET 
    def index
      
    end
  
    # GET
    def show
    end
  
    # GET 
    def new
        @workout_post = WorkoutPost.new
        @exercise_post = ExercisePost.new
    end
  
    # GET 
    def edit
    end
  
    # POST 
    def create

        workout_post = WorkoutPost.new(title: params[:workout_post][:title], date_created: Date.today)

        submitted_exercise_posts = params[:workout_post][:exercise_post]

        exercise_posts = []

        if !workout_post.valid?
            # stop 
        end


        submitted_exercise_posts.each do |index, ep|
            exercise_posts << ExercisePost.new(
                workout_post: workout_post,
                exercise_id: ep[:exercise_id],
                specific_instructions: ep[:specific_instructions],
                is_ranked: ep[:is_ranked] == "1"
            )
        end



        respond_to do |format|
            if workout_post.valid? && exercise_posts.all? {|ep| ep.valid?}
                workout_post.save
                exercise_posts.each(&:save!)
              format.html { redirect_to '/', notice: "Workout was successfully posted" }
              # format.json { render :show, status: :created, location: workout_submission }
            else
                puts 'nope'
              format.html { render :new, status: :unprocessable_entity }
            #   format.json { render json: workout_submission.errors, status: :unprocessable_entity }
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
    def set_exercises
      @exercises = Exercise.all
    end

    def initialize_ep
        @exercise_post = ExercisePost.new
    end

 

    def workout_post_params
      params.require(:workout_post).permit(:title, :date_created)
    end
    
    def exercise_post_params
        params.require(:exercise_post).permit(:exercise_id, :workout_post_id, :specific_instructions, :is_ranked)
    end


    #   # Only allow a list of trusted parameters through.
    #   def ocrtracker_params
    #     params.require(:ocrtracker).permit(:W.I.P)
    #   end
  end
  