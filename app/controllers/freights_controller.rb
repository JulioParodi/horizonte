class FreightsController < ApplicationController
  before_action :set_freight, only: [:show, :edit, :update, :destroy]

  def index
    @freights = Freight.all.sort_by { |freight| [freight.truck.plate, freight.date_freight] }
    @id_truck = 0
    @freights = index_filter_truck_and_date(@freights,@id_truck)
    @soma = index_soma_value_left(@freights)
  end

  def show

  end

  def destroy
    @freight.destroy
    redirect_to freights_path
  end

  def new
    @freight = Freight.new(truck_id: params[:format])
  end

  def edit
    puts @freight.value_left
  end

  def update
    if @freight.update(freight_params)
      puts "success"
    else
      puts "error uptade freight"
    end
    redirect_to @freight
  end

  def create
    @freight = Freight.new(freight_params)
    if @freight.save
      puts "success"
    else
      puts "error create freight"
    end
    redirect_to @freight
  end


  def index_filter_truck_and_date (freights,id_truck)

    if params[:freight].present?
      freights = filter_search_truck(freights, id_truck)
    end
    if params[:search].present?

      @start_date = params[:search][:start_date].to_date
      @end_date = params[:search][:end_date].to_date

      if (@start_date.blank? && @end_date.blank?)
        #nop
      elsif @start_date > @end_date
        flash[:error] = "Error filtragem: Data inicio maior que Data final"
      else
        freights = filter_search_date(freights, @start_date, @end_date)
      end
    end
    freights
  end

  def filter_search_truck (freights,id_truck)

    if params[:freight][:truck_id] != ""
      @id_truck = params[:freight][:truck_id].to_i
      @plate_truck = Truck.find(@id_truck).plate
      aux = []
      freights.each do |f|
        if (f.truck_id) == @id_truck
          aux << f
        end
      end
      return aux
    end
    return freights
  end

  def filter_search_date (freights, start_date, end_date)
      aux = []
      freights.each do |f|
        if f.date_freight >= start_date && f.date_freight <= end_date
          aux << f
        end
      end
      return aux
  end


  def index_soma_value_left (freights)
    soma = 0
    freights.each do |f|
      soma = soma + f.value_left
    end
    soma
  end


  private

    def set_freight
      @freight = Freight.find(params[:id])
    end

    def freight_params
      params.require(:freight).permit(:value_left, :value_freight, :date_freight, :source_freight, :destiny_freight, :truck_id )

    end

    def selected_date(symbol)
      params[:search].present? && params[:search][symbol].present? ? params[:search][symbol].to_date : Time.now.to_date
    end
end
