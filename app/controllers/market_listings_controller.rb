class MarketListingsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_market_listing, only: [:show, :edit, :update, :destroy]

  # GET /market_listings
  # GET /market_listings.json
  def index
    @market_listings = MarketListing.all.paginate(page: params[:page], per_page: 20)
  end

  # GET /market_listings/1
  # GET /market_listings/1.json
  def show
  end

  # GET /market_listings/new
  def new
    @market_listing = MarketListing.new
  end

  # GET /market_listings/1/edit
  def edit
  end

  # POST /market_listings
  # POST /market_listings.json
  def create
    @market_listing = MarketListing.new(market_listing_params)

    respond_to do |format|
      if @market_listing.save
        format.html { redirect_to @market_listing, notice: 'Market listing was successfully created.' }
        format.json { render :show, status: :created, location: @market_listing }
      else
        format.html { render :new }
        format.json { render json: @market_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /market_listings/1
  # PATCH/PUT /market_listings/1.json
  def update
    respond_to do |format|
      if @market_listing.update(market_listing_params)
        format.html { redirect_to @market_listing, notice: 'Market listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @market_listing }
      else
        format.html { render :edit }
        format.json { render json: @market_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /market_listings/1
  # DELETE /market_listings/1.json
  def destroy
    @market_listing.destroy
    respond_to do |format|
      format.html { redirect_to market_listings_url, notice: 'Market listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_listing
      @market_listing = MarketListing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def market_listing_params
      params.require(:market_listing).permit(:transaction_id, :transaction_id_high, :index, :appid, :contextid, :is_credit, :name, :market_name, :market_hash_name, :name_color, :background_color, :assetid, :classid, :instanceid, :icon_url, :date_acted, :date_listed, :price, :seller)
    end
end
