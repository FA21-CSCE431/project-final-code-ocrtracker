class ApplicationController < ActionController::Base
  if Rails.env.production?
    before_action :authenticate_user!
  end
end
