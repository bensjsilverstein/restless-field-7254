require 'rails_helper'

# User Story 1, Flights Index Page
#
# As a visitor
# When I visit the flights index page
# I see a list of all flight numbers
# And next to each flight number I see the name of the Airline of that flight
# And under each flight number I see the names of all that flight's passengers

RSpec.describe 'flights index page' do
  it "has a list of all flight numbers with their airlines and passengers" do
    united = Airline.create!(name: "United")
    frontier = Airline.create!(name: "Frontier")

    denver = united.flights.create!(number: "1111", date: "1/1/2022", departure_city: "Denver", arrival_city: "Miami")
    atlanta = united.flights.create!(number: "2222", date: "1/1/2022", departure_city: "Atlanta", arrival_city: "Miami")
    phoenix = frontier.flights.create!(number: "3333", date: "1/1/2022", departure_city: "Phoenix", arrival_city: "Miami")
    seattle = frontier.flights.create!(number: "1111", date: "1/1/2022", departure_city: "Seattle", arrival_city: "Miami")
    dallas = frontier.flights.create!(number: "1111", date: "1/1/2022", departure_city: "Dallas", arrival_city: "Miami")
    austin = frontier.flights.create!(number: "1111", date: "1/1/2022", departure_city: "Austin", arrival_city: "Miami")

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

    visit("/flights")

    expect(page).to have_content("#{denver.number} - #{denver.airline.name}")
    expect(page).to have_content("#{atlanta.number} - #{atlanta.airline.name}")
    expect(page).to have_content("#{phoenix.number} - #{phoenix.airline.name}")
    within '#flight0' do
      expect(page).to have_content("#{denver.number} - #{denver.airline.name}")
      expect(page).to have_content("#{ben.name}")
      expect(page).to have_content("#{chris.name}")
      expect(page).to have_content("#{phil.name}")

      expect(page).to_not have_content("#{atlanta.number} - #{atlanta.airline.name}")
      expect(page).to_not have_content("#{mike.name}")
    end
    within '#flight1' do
      expect(page).to have_content("#{atlanta.number} - #{atlanta.airline.name}")
      expect(page).to have_content("#{mike.name}")

      expect(page).to_not have_content("#{denver.number} - #{denver.airline.name}")
      expect(page).to_not have_content("#{ben.name}")
    end
    within '#flight2' do
      expect(page).to have_content("#{phoenix.number} - #{phoenix.airline.name}")
      expect(page).to have_content("#{bryce.name}")

      expect(page).to_not have_content("#{denver.number} - #{denver.airline.name}")
      expect(page).to_not have_content("#{ben.name}")
    end
    within '#flight4' do
      expect(page).to have_content("#{phoenix.number} - #{phoenix.airline.name}")

      expect(page).to_not have_content("#{denver.number} - #{denver.airline.name}")
      expect(page).to_not have_content("#{ben.name}")
    end
    within '#flight5' do
      expect(page).to have_content("#{phoenix.number} - #{phoenix.airline.name}")

      expect(page).to_not have_content("#{denver.number} - #{denver.airline.name}")
      expect(page).to_not have_content("#{ben.name}")
    end
  end

  it "can remove a passenger from a flight" do
    united = Airline.create!(name: "United")
    frontier = Airline.create!(name: "Frontier")

    denver = united.flights.create!(number: "1111", date: "1/1/2022", departure_city: "Denver", arrival_city: "Miami")
    atlanta = united.flights.create!(number: "2222", date: "1/1/2022", departure_city: "Atlanta", arrival_city: "Miami")
    phoenix = frontier.flights.create!(number: "3333", date: "1/1/2022", departure_city: "Phoenix", arrival_city: "Miami")
    seattle = frontier.flights.create!(number: "1111", date: "1/1/2022", departure_city: "Seattle", arrival_city: "Miami")
    dallas = frontier.flights.create!(number: "1111", date: "1/1/2022", departure_city: "Dallas", arrival_city: "Miami")

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

    visit("/flights")

    within '#flight0' do
      expect(page).to have_content("#{denver.number} - #{denver.airline.name}")
      expect(page).to have_content("#{ben.name}")
      expect(page).to have_content("#{chris.name}")
      expect(page).to have_content("#{phil.name}")

      click_on "Remove #{ben.name}"
      expect(current_path).to eq("/flights")
      
      expect(page).to_not have_content("#{ben.name}")
      expect(page).to have_content("#{chris.name}")
      expect(page).to have_content("#{phil.name}")
    end
  end

end
