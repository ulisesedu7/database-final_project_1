# == Schema Information
#
# Table name: sellers
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Seller < ApplicationRecord
  # Relationships
  has_many :available_properties
  has_many :sold_properties

  # Validations
  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Validate the uniqueness of the email
  validates :email, uniqueness: true
end
