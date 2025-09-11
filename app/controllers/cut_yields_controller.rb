class CutYieldsController < ApplicationController
  before_action :set_cut_yield, only: %i[ show edit update destroy ]

  # GET /cut_yields or /cut_yields.json
  def index
    @cut_yields = CutYield.all
    @cut_yield = CutYield.new
  end

  # GET /cut_yields/1 or /cut_yields/1.json
  def show
  end

  # GET /cut_yields/new
  def new
    @cut_yield = CutYield.new
  end

  # GET /cut_yields/1/edit
  def edit
  end

  # POST /cut_yields or /cut_yields.json
  def create
    @cut_yield = CutYield.new(cut_yield_params)

    respond_to do |format|
      if @cut_yield.save
        format.html { redirect_to @cut_yield, notice: "Cut yield was successfully created." }
        format.json { render :show, status: :created, location: @cut_yield }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cut_yield.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cut_yields/1 or /cut_yields/1.json
  def update
    respond_to do |format|
      if @cut_yield.update(cut_yield_params)
        format.html { redirect_to @cut_yield, notice: "Cut yield was successfully updated." }
        format.json { render :show, status: :ok, location: @cut_yield }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cut_yield.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cut_yields/1 or /cut_yields/1.json
  def destroy
    @cut_yield.destroy!

    respond_to do |format|
      format.html { redirect_to cut_yields_path, status: :see_other, notice: "Cut yield was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def cut_yield_params
    params.require(:cut_yield).permit(
      :board_length,
      :board_length_unit,
      :piece_length,
      :piece_length_unit,
      :pieces_count,
      :waste_length,
      :waste_length_unit,
      :project_id
    )
  end
end
