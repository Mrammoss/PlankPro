class CutYieldsController < ApplicationController
  before_action :authenticate_user!

  # GET /cut_yields or /cut_yields.json
  def index
    @cut_yields = current_user.cut_yields.order(created_at: :desc)
  end

  # GET /cut_yields/1 or /cut_yields/1.json
  def show
    @cut_yield = current_user.cut_yield.find(params[:id])
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
    @cut_yield = current_user.cut_yields.new(cut_yield_params)

    if @cut_yield.save
      redirect_to cut_yields_path, notice: "Cut yield added successfully!"
    else
      render :index
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
      :name,
      :board_length_whole,
      :board_length_numerator,
      :board_length_denominator,
      :piece_length_whole,
      :piece_length_numerator,
      :piece_length_denominator,
    )
  end
end
