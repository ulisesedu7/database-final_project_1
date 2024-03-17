# == Schema Information
#
# Table name: agents
#
#  id              :bigint           not null, primary key
#  base_commission :decimal(, )
#  contract_date   :date
#  email           :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Agent < ApplicationRecord
  # Relationships
  has_many :sold_properties
  # Using a separate join model for the many-to-many relationship
  has_many :available_properties_by_agents
  has_many :available_properties, through: :available_properties_by_agents

  # Validations
  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :base_commission, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :contract_date, presence: true

  # Validate that the agent's email is unique
  validates :email, uniqueness: true

end
