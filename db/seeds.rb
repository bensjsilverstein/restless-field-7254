# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

united = Airline.create!(name: "United")
frontier = Airline.create!(name: "Frontier")

denver = united.flights.create!(number: "1111", date: "1/1/2022", departure_city: "Denver", arrival_city: "Miami")
atlanta = united.flights.create!(number: "2222", date: "1/1/2022", departure_city: "Atlanta", arrival_city: "Miami")
phoenix = frontier.flights.create!(number: "3333", date: "1/1/2022", departure_city: "Phoenix", arrival_city: "Miami")

ben = Passenger.create!(name: "Ben", age: 29)
chris = Passenger.create!(name: "Chris", age: 30)
phil = Passenger.create!(name: "Phil", age: 31)
mike = Passenger.create!(name: "Mike", age: 32)
bryce = Passenger.create!(name: "Bryce", age: 33)

FlightPassenger.create!(flight_id: denver.id, passenger_id: ben.id)
FlightPassenger.create!(flight_id: denver.id, passenger_id: chris.id)
FlightPassenger.create!(flight_id: denver.id, passenger_id: phil.id)
FlightPassenger.create!(flight_id: atlanta.id, passenger_id: mike.id)
FlightPassenger.create!(flight_id: phoenix.id, passenger_id: bryce.id)
