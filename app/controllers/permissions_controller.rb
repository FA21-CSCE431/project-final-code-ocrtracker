# frozen_string_literal: true

class PermissionsController < ApplicationController
  before_action :require_admin

  def index
    @users = User.where.not(email: 'tamuocr@gmail.com')
  end

  def complete
    submitted_hash = params[:user]

    permanent_admin = User.where(email: 'tamuocr@gmail.com').first
    submitted_hash = submitted_hash.except(permanent_admin.id) if permanent_admin

    User.update(submitted_hash.keys, submitted_hash.values.map { |x| { is_admin: x[:is_admin] } })
    respond_to do |format|
      format.html { redirect_to permissions_url }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to permissions_url, notice: 'User removed' }
    end
  end
end
