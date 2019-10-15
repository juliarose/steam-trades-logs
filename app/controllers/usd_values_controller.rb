class UsdValuesController < ApplicationController
  before_action :set_usd_value, only: [:show, :edit, :update, :destroy]

  # GET /usd_values
  # GET /usd_values.json
  def index
    @usd_values = UsdValue.all
  end

  # GET /usd_values/1
  # GET /usd_values/1.json
  def show
  end

  # GET /usd_values/new
  def new
    @usd_value = UsdValue.new
  end

  # GET /usd_values/1/edit
  def edit
  end

  # POST /usd_values
  # POST /usd_values.json
  def create
    @usd_value = UsdValue.new(usd_value_params)

    respond_to do |format|
      if @usd_value.save
        format.html { redirect_to @usd_value, notice: 'Usd value was successfully created.' }
        format.json { render :show, status: :created, location: @usd_value }
      else
        format.html { render :new }
        format.json { render json: @usd_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usd_values/1
  # PATCH/PUT /usd_values/1.json
  def update
    respond_to do |format|
      if @usd_value.update(usd_value_params)
        format.html { redirect_to @usd_value, notice: 'Usd value was successfully updated.' }
        format.json { render :show, status: :ok, location: @usd_value }
      else
        format.html { render :edit }
        format.json { render json: @usd_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usd_values/1
  # DELETE /usd_values/1.json
  def destroy
    @usd_value.destroy
    respond_to do |format|
      format.html { redirect_to usd_values_url, notice: 'Usd value was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usd_value
      @usd_value = UsdValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usd_value_params
      params.require(:usd_value).permit(:value, :date)
    end
end
