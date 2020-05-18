class ScmValuesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_scm_value, only: [:show, :edit, :update, :destroy]

  # GET /scm_values
  # GET /scm_values.json
  def index
    @scm_values = ScmValue.all
  end

  # GET /scm_values/1
  # GET /scm_values/1.json
  def show
  end

  # GET /scm_values/new
  def new
    @scm_value = ScmValue.new
  end

  # GET /scm_values/1/edit
  def edit
  end

  # POST /scm_values
  # POST /scm_values.json
  def create
    @scm_value = ScmValue.new(scm_value_params)

    respond_to do |format|
      if @scm_value.save
        format.html { redirect_to @scm_value, notice: 'Scm value was successfully created.' }
        format.json { render :show, status: :created, location: @scm_value }
      else
        format.html { render :new }
        format.json { render json: @scm_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scm_values/1
  # PATCH/PUT /scm_values/1.json
  def update
    respond_to do |format|
      if @scm_value.update(scm_value_params)
        format.html { redirect_to @scm_value, notice: 'Scm value was successfully updated.' }
        format.json { render :show, status: :ok, location: @scm_value }
      else
        format.html { render :edit }
        format.json { render json: @scm_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scm_values/1
  # DELETE /scm_values/1.json
  def destroy
    @scm_value.destroy
    respond_to do |format|
      format.html { redirect_to scm_values_url, notice: 'Scm value was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scm_value
      @scm_value = ScmValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scm_value_params
      params.require(:scm_value).permit(:value, :date)
    end
end
