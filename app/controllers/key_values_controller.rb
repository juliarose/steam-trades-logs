class KeyValuesController < ApplicationController
  before_action :set_key_value, only: [:show, :edit, :update, :destroy]

  # GET /key_values
  # GET /key_values.json
  def index
    @key_values = KeyValue.all
  end

  # GET /key_values/1
  # GET /key_values/1.json
  def show
  end

  # GET /key_values/new
  def new
    @key_value = KeyValue.new
  end

  # GET /key_values/1/edit
  def edit
  end

  # POST /key_values
  # POST /key_values.json
  def create
    @key_value = KeyValue.new(key_value_params)

    respond_to do |format|
      if @key_value.save
        format.html { redirect_to @key_value, notice: 'Key value was successfully created.' }
        format.json { render :show, status: :created, location: @key_value }
      else
        format.html { render :new }
        format.json { render json: @key_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /key_values/1
  # PATCH/PUT /key_values/1.json
  def update
    respond_to do |format|
      if @key_value.update(key_value_params)
        format.html { redirect_to @key_value, notice: 'Key value was successfully updated.' }
        format.json { render :show, status: :ok, location: @key_value }
      else
        format.html { render :edit }
        format.json { render json: @key_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /key_values/1
  # DELETE /key_values/1.json
  def destroy
    @key_value.destroy
    respond_to do |format|
      format.html { redirect_to key_values_url, notice: 'Key value was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_key_value
      @key_value = KeyValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def key_value_params
      params.require(:key_value).permit(:value, :date)
    end
end
