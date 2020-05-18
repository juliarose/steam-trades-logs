class MarketplaceSalesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_marketplace_sale, only: [:show, :edit, :update, :destroy]

  # GET /marketplace_sales
  # GET /marketplace_sales.json
  def index
    @marketplace_sales = MarketplaceSale.all.paginate(page: params[:page], per_page: 20)
  end

  # GET /marketplace_sales/1
  # GET /marketplace_sales/1.json
  def show
  end

  # GET /marketplace_sales/new
  def new
    @marketplace_sale = MarketplaceSale.new
  end

  # GET /marketplace_sales/1/edit
  def edit
  end

  # POST /marketplace_sales
  # POST /marketplace_sales.json
  def create
    @marketplace_sale = MarketplaceSale.new(marketplace_sale_params)

    respond_to do |format|
      if @marketplace_sale.save
        format.html { redirect_to @marketplace_sale, notice: 'Marketplace sale was successfully created.' }
        format.json { render :show, status: :created, location: @marketplace_sale }
      else
        format.html { render :new }
        format.json { render json: @marketplace_sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marketplace_sales/1
  # PATCH/PUT /marketplace_sales/1.json
  def update
    respond_to do |format|
      if @marketplace_sale.update(marketplace_sale_params)
        format.html { redirect_to @marketplace_sale, notice: 'Marketplace sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @marketplace_sale }
      else
        format.html { render :edit }
        format.json { render json: @marketplace_sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marketplace_sales/1
  # DELETE /marketplace_sales/1.json
  def destroy
    @marketplace_sale.destroy
    respond_to do |format|
      format.html { redirect_to marketplace_sales_url, notice: 'Marketplace sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_sale
      @marketplace_sale = MarketplaceSale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marketplace_sale_params
      params.require(:marketplace_sale).permit(:earned_credit, :transaction_id, :date)
    end
end
