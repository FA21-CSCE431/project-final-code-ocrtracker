# frozen_string_literal: true

# Posts Controller
class WodController < ApplicationController
  
    before_action :set_workout_posts, only: %i[index]
    before_action :require_admin, only: %i[index update_wod remove]
  
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


      if params[:wod_history][:wod_date].empty?
        respond_to do |format|
          msg = { :status => 'failure', :message => "Failed to update #{workout_post.title}"}
          format.json{render :json => msg}
        end

      else
        workout_post.wod_history.update(wod_date: params[:wod_history][:wod_date])
  
        workout_post.save
        respond_to do |format|
          msg = { :status => 'success', :message => "Successfully updated #{workout_post.title}"}
          format.json{render :json => msg}
        end
        
      end

    end

    def remove
      workout_post = WorkoutPost.find(params[:workout_post_id])

      # Destroy the wod_history entity associated with the workout post (if one exists)
      workout_post.wod_history.destroy unless workout_post.wod_history.new_record?

      respond_to do |format|
        msg = { :status => 'success', :message => "Successfully deleted WOD history date for #{workout_post.title}"}
        format.json{render :json => msg}
      end

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
  
  end
  