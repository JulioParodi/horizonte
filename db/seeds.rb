# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


  puts "--------Carregando Caminhões------"

  Truck.create! ([
  { plate: "AZL-8763", mark: 'Renault - clio' } ,
  { plate: 'AWG-4314', mark: 'Yamaha - fazer 250' },
  { plate: 'DPR-0052', mark: 'Chevrolet - vectra' },
  { plate: 'AGR-0024', mark: 'Volvo - nh12'}
    ])

  puts "--------Carregando Caminhões------[OK]"
  puts "--------Carregando Fretes------"

  20.times do |i|
    Freight.create!(value_freight: Faker::Number.decimal(4,2) , value_left: Faker::Number.decimal(4,2),date_freight: Faker::Date.between(100.days.ago, Date.today), source_freight: Faker::Address.city ,destiny_freight: Faker::Address.city, truck_id: Faker::Number.between(1,4) )
  end

  puts "--------Carregando Fretes------[OK]"
