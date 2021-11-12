# frozen_string_literal: true

class DocumentationController < ApplicationController
  def index
    @current_user = current_user
  end
end
