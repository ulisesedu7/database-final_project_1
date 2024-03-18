class CreateSoldProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :sold_properties do |t|
      t.string :name
      t.string :city
      t.string :address
      t.decimal :sale_price
      t.integer :bedrooms
      t.boolean :has_pool
      t.date :sale_date
      t.references :buyer, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: true
      t.decimal :agent_commission
      t.references :agent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
