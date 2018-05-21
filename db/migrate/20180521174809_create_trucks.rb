class CreateTrucks < ActiveRecord::Migration[5.0]
  def change
    create_table :trucks do |t|
      t.string :plate
      t.string :mark

      t.timestamps
    end
  end
end
