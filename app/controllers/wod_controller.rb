# frozen_string_literal: true

# Posts Controller
class WodController < ApplicationController
  
    before_action :set_workout_posts, only: %i[index]
    before_action :require_admin, only: %i[index update_wod]
  
    # GET
    def index
        
    end
  
    # GET
    def show; end
  
    # GET
    def new; end
  
    # GET
    def edit; end
  
    # POST
    def create; end
  
    def update_wod
      workout_post = WorkoutPost.find(params[:wod_history][:workout_post_id])

      workout_post.wod_history.update(wod_date: params[:wod_history][:wod_date])

      workout_post.save!

      # flash.now[:notice] = 'a'

      respond_to do |format|
        msg = { :status => 'success', :message => "Successfully updated #{workout_post.title}"}
        format.json{render :json => msg}
      end
      # render json: {status: 'success', message: 'Successfully updated'}

      # wodh = WodHistory.find_or_create_by(workout_post: workout_post)
      # wodh.wod_date = params[:wod_history][:wod_date]
  
      # workout_post.wod_history = wodh
      # workout_post.save!
    end
  
    # PATCH/PUT
    def update; end
  
    # DELETE
    def destroy; end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
  
    def set_workout_posts
      # TODO change this to show the last 10? Made within the last week?
      @workout_posts = WorkoutPost.all
    end

    # def wod_history_params
    #   params.require(:wod_history).permit(:wod_date)
    # end
  
  end
  