# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!, :set_profile, only: %i[show edit update]
  before_action :profile_owner, only: %i[edit update]

  def index
    @profile = User.all
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @profile.update(user_params)
        format.html { redirect_to "/profiles/#{current_user.id}", notice: 'Profile was successfully updated' }
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
    params.require(:user).permit(:description, :avatar_url)
  end

  def profile_owner
    return if @profile.id == current_user.id

    flash[:notice] = 'Access denied as you are not owner of this profile'
    redirect_to root_path
  end
end
