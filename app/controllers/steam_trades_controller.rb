class SteamTradesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_steam_trade, only: [:show, :edit, :update, :destroy]

  # GET /steam_trades
  # GET /steam_trades.json
  def index
    # find the bot if this is a nested route
    @bot = Bot.find(params[:bot_id]) if params[:bot_id]
    
    steamid = @bot ? @bot.uid : params[:steamid]
    
    query_params = {
        :full_name => params[:name],
        :steamid => steamid,
        :steamid_other => params[:steamid_other]
    }.compact
    
    @bot_id = params[:bot_id]
    @pagy, @steam_trades = pagy(SteamTrade
      .includes(:steam_trade_items => :item)
      .where(query_params)
      .order('traded_at DESC')
    )
  end

  # GET /steam_trades/1
  # GET /steam_trades/1.json
  def show
    @received_items, @given_items = SteamTradeItem
      .preload(:item)
      .where(:steam_trade_id => @steam_trade.id)
      .partition(&:is_their_item)
  end

  # GET /steam_trades/new
  def new
    @steam_trade = SteamTrade.new
  end

  # GET /steam_trades/1/edit
  def edit
  end

  # POST /steam_trades
  # POST /steam_trades.json
  def create
    @steam_trade = SteamTrade.new(steam_trade_params)

    respond_to do |format|
      if @steam_trade.save
        format.html { redirect_to @steam_trade, notice: 'SteamTrade was successfully created.' }
        format.json { render :show, status: :created, location: @steam_trade }
      else
        format.html { render :new }
        format.json { render json: @steam_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steam_trades/1
  # PATCH/PUT /steam_trades/1.json
  def update
    respond_to do |format|
      if @steam_trade.update(steam_trade_params)
        format.html { redirect_to @steam_trade, notice: 'SteamTrade was successfully updated.' }
        format.json { render :show, status: :ok, location: @steam_trade }
      else
        format.html { render :edit }
        format.json { render json: @steam_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steam_trades/1
  # DELETE /steam_trades/1.json
  def destroy
    @steam_trade.destroy
    respond_to do |format|
      format.html { redirect_to steam_trades_url, notice: 'SteamTrade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_steam_trade
      @steam_trade = SteamTrade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def steam_trade_params
      params.require(:steam_trade).permit(:steamid, :steamid_other, :traded_at, :trade_offer_state)
    end
end
