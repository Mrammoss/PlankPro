class MiterFramesController < ApplicationController
  before_action :set_miter_frame, only: %i[ show edit update destroy ]

  # GET /miter_frames or /miter_frames.json
  def index
    @miter_frames = current_user.miter_frames.order(created_at: :desc)
  end

  # GET /miter_frames/1 or /miter_frames/1.json
  def show
  end

  # GET /miter_frames/new
  def new
    @miter_frame = MiterFrame.new
  end

  # GET /miter_frames/1/edit
  def edit
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
  def update
    respond_to do |format|
      if @miter_frame.update(miter_frame_params)
        format.html { redirect_to @miter_frame, notice: "Miter frame was successfully updated." }
        format.json { render :show, status: :ok, location: @miter_frame }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @miter_frame.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /miter_frames/1 or /miter_frames/1.json
  def destroy
    @miter_frame.destroy!

    respond_to do |format|
      format.html { redirect_to miter_frames_path, status: :see_other, notice: "Miter frame was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Only allow a list of trusted parameters through.
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
