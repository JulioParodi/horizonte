class CreateFreights < ActiveRecord::Migration[5.0]
  def change
    create_table :freights do |t|
      t.float :value_freight
      t.float :value_left
      t.date :date_freight
      t.string :source_freight
      t.string :destiny_freight
      t.references :truck, foreign_key: true
      t.timestamps
    end
  end
end
