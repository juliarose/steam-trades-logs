class BotsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_bot, only: [:show, :edit, :update, :destroy]

  # GET /bots
  # GET /bots.json
  def index
    @bots = Bot.all
  end

  # GET /bots/1
  # GET /bots/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bot
      @bot = Bot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bot_params
      params.require(:bot).permit(:value, :date)
    end
end
