class MiterFramesController < ApplicationController
  before_action :set_miter_frame, only: %i[ show edit update destroy ]

  # GET /miter_frames or /miter_frames.json
  def index
    @miter_frames = MiterFrame.all
    @miter_frame = MiterFrame.new
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
    @miter_frame = MiterFrame.new(miter_frame_params)

    respond_to do |format|
      if @miter_frame.save
        format.html { redirect_to @miter_frame, notice: "Miter frame was successfully created." }
        format.json { render :show, status: :created, location: @miter_frame }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @miter_frame.errors, status: :unprocessable_entity }
      end
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
      :inside_width,
      :inside_width_unit,
      :inside_height,
      :inside_height_unit,
      :board_width,
      :board_width_unit,
      :joint_angle,
      :miter_angle_one,
      :miter_angle_two,
      :piece_length,
      :piece_length_unit,
      :total_material,
      :total_material_unit,
      :waste_length,
      :waste_length_unit,
      :project_id
    )
  end
end
