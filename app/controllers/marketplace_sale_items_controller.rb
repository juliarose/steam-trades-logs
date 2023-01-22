class MarketplaceSaleItemsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_marketplace_sale_item, only: [:show, :edit, :update, :destroy]

  # GET /marketplace_sale_items
  # GET /marketplace_sale_items.json
  def index
    @pagy, @marketplace_sale_items = pagy(MarketplaceSaleItem.all)
  end

  # GET /marketplace_sale_items/1
  # GET /marketplace_sale_items/1.json
  def show
  end

  # GET /marketplace_sale_items/new
  def new
    @marketplace_sale_item = MarketplaceSaleItem.new
  end

  # GET /marketplace_sale_items/1/edit
  def edit
  end

  # POST /marketplace_sale_items
  # POST /marketplace_sale_items.json
  def create
    @marketplace_sale_item = MarketplaceSaleItem.new(marketplace_sale_item_params)

    respond_to do |format|
      if @marketplace_sale_item.save
        format.html { redirect_to @marketplace_sale_item, notice: 'Marketplace sale item was successfully created.' }
        format.json { render :show, status: :created, location: @marketplace_sale_item }
      else
        format.html { render :new }
        format.json { render json: @marketplace_sale_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marketplace_sale_items/1
  # PATCH/PUT /marketplace_sale_items/1.json
  def update
    respond_to do |format|
      if @marketplace_sale_item.update(marketplace_sale_item_params)
        format.html { redirect_to @marketplace_sale_item, notice: 'Marketplace sale item was successfully updated.' }
        format.json { render :show, status: :ok, location: @marketplace_sale_item }
      else
        format.html { render :edit }
        format.json { render json: @marketplace_sale_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marketplace_sale_items/1
  # DELETE /marketplace_sale_items/1.json
  def destroy
    @marketplace_sale_item.destroy
    respond_to do |format|
      format.html { redirect_to marketplace_sale_items_url, notice: 'Marketplace sale item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_sale_item
      @marketplace_sale_item = MarketplaceSaleItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marketplace_sale_item_params
      params.require(:marketplace_sale_item).permit(:marketplace_sale_id, :price, :assetid, :asset_original_id, :full_name, :defindex, :particle_id, :quality_id, :killstreak_tier_id, :skin_name, :item_name, :wear_id, :sku, :full_sku)
    end
end
