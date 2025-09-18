class MiterFramesController < ApplicationController
  before_action :set_miter_frame, only: [:destroy]

  # GET /miter_frames or /miter_frames.json
  def index
    @miter_frames = current_user.miter_frames.order(:name)
  end

  # GET /miter_frames/new
  def new
    @miter_frame = MiterFrame.new
  end

  # POST /miter_frames or /miter_frames.json
  def create
    @miter_frame = current_user.miter_frames.new(miter_frame_params)

    if @miter_frame.save
      redirect_to miter_frames_path, notice: "Miter frame added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /miter_frames/1 or /miter_frames/1.json

  # DELETE /miter_frames/1 or /miter_frames/1.json
  def destroy
    @miter_frame.destroy
    redirect_to miter_frames_path, notice: "Miter Frame was successfully destroyed."
  end

  private

  def set_miter_frame
    @miter_frame = current_user.miter_frames.find(params[:id])
  end

  def miter_frame_params
    params.require(:miter_frame).permit(
      :name,
      :shape_type,
      :inside_length_whole,
      :inside_length_numerator,
      :inside_length_denominator,
      :outside_length_whole,
      :outside_length_numerator,
      :outside_length_denominator,
      :board_width_whole,
      :board_width_numerator,
      :board_width_denominator,
      :miter_angle
    )
  end
end
