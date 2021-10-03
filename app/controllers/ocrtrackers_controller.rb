# frozen_string_literal: true

class OcrtrackersController < ApplicationController
  before_action :set_ocrtracker, only: %i[show edit update destroy]

  # GET /ocrtrackers or /ocrtrackers.json
  def index
    @ocrtrackers = Ocrtracker.all
  end

  # GET /ocrtrackers/1 or /ocrtrackers/1.json
  def show; end

  # GET /ocrtrackers/new
  def new
    @ocrtracker = Ocrtracker.new
  end

  # GET /ocrtrackers/1/edit
  def edit; end

  # POST /ocrtrackers or /ocrtrackers.json
  def create
    @ocrtracker = Ocrtracker.new(ocrtracker_params)

    respond_to do |format|
      if @ocrtracker.save
        format.html { redirect_to @ocrtracker, notice: 'Ocrtracker was successfully created.' }
        format.json { render :show, status: :created, location: @ocrtracker }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ocrtracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ocrtrackers/1 or /ocrtrackers/1.json
  def update
    respond_to do |format|
      if @ocrtracker.update(ocrtracker_params)
        format.html { redirect_to @ocrtracker, notice: 'Ocrtracker was successfully updated.' }
        format.json { render :show, status: :ok, location: @ocrtracker }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ocrtracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ocrtrackers/1 or /ocrtrackers/1.json
  def destroy
    @ocrtracker.destroy
    respond_to do |format|
      format.html { redirect_to ocrtrackers_url, notice: 'Ocrtracker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ocrtracker
    @ocrtracker = Ocrtracker.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ocrtracker_params
    params.require(:ocrtracker).permit(:W.I.P)
  end
end
