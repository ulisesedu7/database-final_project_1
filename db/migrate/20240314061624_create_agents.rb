class CreateAgents < ActiveRecord::Migration[7.1]
  def change
    create_table :agents do |t|
      t.string :name
      t.string :email
      t.date :contract_date
      t.decimal :base_commission

      t.timestamps
    end
  end
end
