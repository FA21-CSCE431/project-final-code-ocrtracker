# frozen_string_literal: true

class MembersController < ApplicationController
  def index
    @users = User.all
  end
end
