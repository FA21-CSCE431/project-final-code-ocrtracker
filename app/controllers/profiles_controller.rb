# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!, :set_profile, only: %i[show edit update]
  before_action :profile_owner, only: %i[edit update]
  before_action :require_admin, only: %i[archive]

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

  def archive
    user = User.find(params[:id])
    respond_to do |format|
      if user.archive
        format.html { redirect_to permissions_url, notice: 'User archived successfully' }
      else
        format.html { redirect_to root_path, notice: 'Could not archive user' }
      end
    end
  end

  def restore
    user = User.unscoped.find(params[:id])
    respond_to do |format|
      if user.un_archive
        format.html { redirect_to permissions_url, notice: 'User restored successfully' }
      else
        format.html { redirect_to root_path, notice: 'Could not restore user' }
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
