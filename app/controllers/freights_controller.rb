class FreightsController < ApplicationController
  before_action :set_freight, only: [:show, :edit, :update, :destroy]

  def index


    @freights = Freight.all


    aux = []
    if params[:search].present?
      @start = params[:search][:start_date].to_date
      @end = params[:search][:end_date].to_date
      puts @start
      puts @end
      @freights.each do |f|
        puts "fora do if"
        if f.date_freight > @start && f.date_freight < @end
          aux << f
        end
      end
      @freights = aux
    end

    aux = []
    @id_truck = 0
    if params.has_key? :format
      @id_truck = params[:format].to_i
      @plate_truck = Truck.find(@id_truck).plate
     @freights.each do |f|
       if (f.truck_id) == @id_truck
          aux << f
       end
     end
      @freights = aux
    end

   @soma = 0
   @freights.each do |f|
     @soma = @soma + f.value_left
   end

  end

  def show

  end

  def destroy
    @freight.destroy
    redirect_to freights_path
  end

  def new
    @freight = Freight.new(truck_id: params[:format])

    puts "--------- new -------------------"
    puts @freight.truck_id

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
    puts "------create-----"
    @freight = Freight.new(freight_params)

    if @freight.save
      puts "success"
    else
      puts "error create freight"
    end
    redirect_to @freight
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
