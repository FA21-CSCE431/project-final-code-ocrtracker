class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update]

  def index
    @profile = User.all
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @profile.update(user_params)
        format.html { redirect_to "/profiles/ #{current_user.id}", notice: 'Profile was successfully updated' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_profile
    @profile = User.find(params[:id])
  end

  def user_params
    params.permit(:description, :avatar_url)
  end
end
