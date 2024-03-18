class CreateAvailablePropertiesByAgents < ActiveRecord::Migration[7.1]
  def change
    create_table :available_properties_by_agents do |t|
      t.references :available_property, null: false, foreign_key: true
      t.references :agent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
