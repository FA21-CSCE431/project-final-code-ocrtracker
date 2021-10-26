# frozen_string_literal: true

class PermissionsController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all
  end

  def complete
    submitted_hash = params[:user]

    respond_to do |format|
      if User.update(submitted_hash.keys, submitted_hash.values.map { |x| { is_admin: x[:is_admin] } })
        format.html { redirect_to permissions_url, notice: 'Users successfully updated' }
      else
        format.html { redirect_to permissions_url, notice: 'Failure' }
      end
    end
  end
end
