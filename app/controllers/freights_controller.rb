class FreightsController < ApplicationController
  before_action :set_freight, only: [:show, :edit, :update, :destroy]
  def index
   @freights = Freight.all
  end

  def show

  end

  def destroy
    @freight.destroy
    redirect_to freights_path
  end

  def new
    @freight = Freight.new
  end

  def edit
    puts "----------------------------"
    puts @freight.value_left
  end

  def update
    if @freight.update(freight_params)
      puts "success"
    else
      puts "error handling"
    end

    redirect_to @freight
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

    def set_freight
      @freight = Freight.find(params[:id])
    end

    def freight_params
      params.require(:freight).permit(:value_left, :value_freight, :date_freight, :source_freight, :destiny_freight)
    end

end
