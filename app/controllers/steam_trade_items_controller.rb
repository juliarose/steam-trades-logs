class SteamTradeItemsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_steam_trade_item, only: [:show, :edit, :update, :destroy]

  # GET /steam_trade_items
  # GET /steam_trade_items.json
  def index
    @steam_trade_items = SteamTradeItem.all.paginate(page: params[:page], per_page: 20)
  end

  # GET /steam_trade_items/1
  # GET /steam_trade_items/1.json
  def show
  end

  # GET /steam_trade_items/new
  def new
    @steam_trade_item = SteamTradeItem.new
  end

  # GET /steam_trade_items/1/edit
  def edit
  end

  # POST /steam_trade_items
  # POST /steam_trade_items.json
  def create
    @steam_trade_item = SteamTradeItem.new(steam_trade_item_params)

    respond_to do |format|
      if @steam_trade_item.save
        format.html { redirect_to @steam_trade_item, notice: 'Steam trade item was successfully created.' }
        format.json { render :show, status: :created, location: @steam_trade_item }
      else
        format.html { render :new }
        format.json { render json: @steam_trade_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steam_trade_items/1
  # PATCH/PUT /steam_trade_items/1.json
  def update
    respond_to do |format|
      if @steam_trade_item.update(steam_trade_item_params)
        format.html { redirect_to @steam_trade_item, notice: 'Steam trade item was successfully updated.' }
        format.json { render :show, status: :ok, location: @steam_trade_item }
      else
        format.html { render :edit }
        format.json { render json: @steam_trade_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steam_trade_items/1
  # DELETE /steam_trade_items/1.json
  def destroy
    @steam_trade_item.destroy
    respond_to do |format|
      format.html { redirect_to steam_trade_items_url, notice: 'Stean trade item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_steam_trade_item
      @steam_trade_item = SteamTradeItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def steam_trade_item_params
      params.require(:steam_trade_item).permit(:assetid, :appid, :contextid, :defindex, :craftable, :skin_name, :killstreak_tier_id, :wear_id)
    end
end
