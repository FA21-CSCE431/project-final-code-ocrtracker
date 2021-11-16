# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!, :set_profile, only: %i[show edit update]
  before_action :profile_owner, only: %i[edit update]

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @profile.update(user_params)
        format.html { redirect_to "/profiles/#{current_user.id}", notice: 'Profile was successfully updated' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { redirect_to edit_profile_path(current_user) }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_profile
    @profile = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:description, :avatar_url, :image)
  end

  def profile_owner
    return if @profile.id == current_user.id

    redirect_to root_path
  end
end
