class CutYieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cut_yield, only: [:destroy]

  # GET /cut_yields or /cut_yields.json
  def index
    @cut_yields = current_user.cut_yields.order(:name)
    @cut_yields = @cut_yields.where("name ILIKE ?", "%#{params[:query]}%") if params[:query].present?

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /cut_yields/new
  def new
    @cut_yield = CutYield.new
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

  # DELETE /cut_yields/1 or /cut_yields/1.json
  def destroy
    @cut_yield.destroy
    redirect_to cut_yields_path, notice: "Cut yield was successfully destroyed."
  end

  private

  def set_cut_yield
    @cut_yield = current_user.cut_yields.find(params[:id])
  end

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
