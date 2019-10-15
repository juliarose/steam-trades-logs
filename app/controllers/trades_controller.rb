class TradesController < ApplicationController
  before_action :set_trade, only: [:show, :edit, :update, :destroy]

  # GET /trades
  # GET /trades.json
  def index
    @trades = Trade.all
  end

  # GET /trades/1
  # GET /trades/1.json
  def show
  end

  # GET /trades/new
  def new
    @trade = Trade.new
  end

  # GET /trades/1/edit
  def edit
  end

  # POST /trades
  # POST /trades.json
  def create
    @trade = Trade.new(trade_params)

    respond_to do |format|
      if @trade.save
        format.html { redirect_to @trade, notice: 'Trade item was successfully created.' }
        format.json { render :show, status: :created, location: @trade }
      else
        format.html { render :new }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trades/1
  # PATCH/PUT /trades/1.json
  def update
    respond_to do |format|
      if @trade.update(trade_params)
        format.html { redirect_to @trade, notice: 'Trade item was successfully updated.' }
        format.json { render :show, status: :ok, location: @trade }
      else
        format.html { render :edit }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trades/1
  # DELETE /trades/1.json
  def destroy
    @trade.destroy
    respond_to do |format|
      format.html { redirect_to trades_url, notice: 'Trade item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade
      @trade = Trade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_params
      params.require(:trade).permit(:assetid, :appid, :contextid, :item_name, :defindex, :craftable, :skin_name, :killstreak_tier_id, :wear_id, :particle_id, :quality_id, :purchased_at, :sold_at, :keys_spent, :scm_spent, :usd_spent, :items_spent, :keys_received, :scm_received, :usd_received, :items_received, :notes, :steamid, :steamid_other)
    end
end
