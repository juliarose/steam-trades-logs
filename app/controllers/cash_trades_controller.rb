class CashTradesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_cash_trade, only: [:show, :edit, :update, :destroy]

  # GET /cash_trades
  # GET /cash_trades.json
  def index
    @cash_trades = CashTrade.all
  end

  # GET /cash_trades/1
  # GET /cash_trades/1.json
  def show
  end

  # GET /cash_trades/new
  def new
    @cash_trade = CashTrade.new
  end

  # GET /cash_trades/1/edit
  def edit
  end

  # POST /cash_trades
  # POST /cash_trades.json
  def create
    @cash_trade = CashTrade.new(cash_trade_params)

    respond_to do |format|
      if @cash_trade.save
        format.html { redirect_to @cash_trade, notice: 'Cash trade was successfully created.' }
        format.json { render :show, status: :created, location: @cash_trade }
      else
        format.html { render :new }
        format.json { render json: @cash_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cash_trades/1
  # PATCH/PUT /cash_trades/1.json
  def update
    respond_to do |format|
      if @cash_trade.update(cash_trade_params)
        format.html { redirect_to @cash_trade, notice: 'Cash trade was successfully updated.' }
        format.json { render :show, status: :ok, location: @cash_trade }
      else
        format.html { render :edit }
        format.json { render json: @cash_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cash_trades/1
  # DELETE /cash_trades/1.json
  def destroy
    @cash_trade.destroy
    respond_to do |format|
      format.html { redirect_to cash_trades_url, notice: 'Cash trade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cash_trade
      @cash_trade = CashTrade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cash_trade_params
      params.require(:cash_trade).permit(:date, :steamid, :tradeid, :steam_trade_id, :txid, :email, :keys, :usd, :processor_id, :notes, screenshots: [])
    end
end
