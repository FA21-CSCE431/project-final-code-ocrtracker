# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def require_admin
    return if current_user.is_admin?

    flash[:error] = 'You must be an admin to access this section'
    redirect_to root_path
  end
end
