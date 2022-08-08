class CreatePassengers < ActiveRecord::Migration[5.2]
  def change
    create_table :passengers do |t|
      t.string :name
      t.integer :age
      t.references :flights, foreign_key: true
    end
  end
end
