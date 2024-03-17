# == Schema Information
#
# Table name: available_properties_by_agents
#
#  id                    :bigint           not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  agent_id              :bigint           not null
#  available_property_id :bigint           not null
#
# Indexes
#
#  index_available_properties_by_agents_on_agent_id               (agent_id)
#  index_available_properties_by_agents_on_available_property_id  (available_property_id)
#
# Foreign Keys
#
#  fk_rails_...  (agent_id => agents.id)
#  fk_rails_...  (available_property_id => available_properties.id)
#
class AvailablePropertiesByAgent < ApplicationRecord
  # Relationships
  belongs_to :available_property
  belongs_to :agent
end
