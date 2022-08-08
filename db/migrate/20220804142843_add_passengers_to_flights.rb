class AddPassengersToFlights < ActiveRecord::Migration[5.2]
  def change
    add_reference :flights, :passengers, foreign_key: true
  end
end
