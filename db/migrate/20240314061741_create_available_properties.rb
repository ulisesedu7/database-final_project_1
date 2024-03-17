class CreateAvailableProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :available_properties do |t|
      t.string :name
      t.string :city
      t.string :address
      t.decimal :listed_price
      t.integer :bedrooms
      t.boolean :has_pool
      t.date :publication_date
      t.references :agent, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: true

      t.timestamps
    end
  end
end
