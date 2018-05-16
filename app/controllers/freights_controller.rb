class FreightsController < ApplicationController

  def index
   @freights = Freight.all
  end

  def show
    @freight = Freight.find(params[:id])
  end

  def new
    @freight = Freight.new
  end

  def create

    @freight = Freight.new(freight_params)
    if @freight.save
      puts "success"
    else
      puts "error handling"
    end
    redirect_to @freight
  end

  private
    def freight_params
      params.require(:freight).permit(:value_left, :value_freight, :date_freight, :source_freight, :destiny_freight)
    end

end
