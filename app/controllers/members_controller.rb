# frozen_string_literal: true

class MembersController < ApplicationController
  def index
    @users = User.where.not(email: 'tamuocr@gmail.com')
  end
end
