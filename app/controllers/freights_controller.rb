class FreightsController < ApplicationController
  before_action :set_freight, only: [:show, :edit, :update, :destroy]



  def index

    @freights = Freight.all.sort_by { |freight| [freight.truck.plate, freight.date_freight] }
    @id_truck = 0
    puts "#-----------------------------#"
    puts @freights
    #FILTRAGEM POR DATAS
    @freights = index_filter_truck_and_date(@freights,@id_truck)
    puts "---------------------------------------------"
    puts @freights
    @freights = index_filter_truck(@freights,@id_truck)
    puts @freights
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
    if params[:search].present?
      freights = filter_search_truck(freights, id_truck)
      puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      puts freights

      @start_date = params[:search][:start_date]
      @end_date = params[:search][:end_date]
      puts @start_date
      puts @end_date
      if (@start_date.blank? && @end_date.blank?)

         flash[:error] = "Data inicio maior que Data final"
        freights = Freight.all.sort_by { |freight| [freight.truck.plate, freight.date_freight] }
      else
        @start_date = @start_date.to_date
        @end_date = @end_date.to_date
      freights = filter_search_date(freights, @start_date, @end_date)

      end
    end
    #@id_truck = id_truck
    freights
  end

  def filter_search_truck (freights,id_truck)
    puts "bbbbbbbbbbbbbbbbbbbbbb"
    puts freights
    if params[:search][:truck_id] != "0"
      puts "iffffffffffffff"
      @id_truck = params[:search][:truck_id].to_i
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
    if start_date != "" && end_date != ""
      aux = []
      freights.each do |f|
        if f.date_freight >= start_date && f.date_freight <= end_date
          aux << f
        end
      end
      return aux
    end
    return freights
  end

  def index_filter_truck (freights, id_truck)
    if params.has_key? :format
      freights = filter_format_truck(freights, id_truck)
    end
    @id_truck = id_truck
    freights
  end

  def filter_format_truck (freights,id_truck)
    if id_truck == 0
      @id_truck = params[:format].to_i
    end
    @plate_truck = Truck.find(@id_truck).plate
    aux = []
    freights.each do |f|
      if (f.truck_id) == @id_truck
        aux << f
      end
    end
    aux
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
