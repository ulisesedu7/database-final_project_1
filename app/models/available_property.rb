# == Schema Information
#
# Table name: available_properties
#
#  id               :bigint           not null, primary key
#  address          :string
#  bedrooms         :integer
#  city             :string
#  has_pool         :boolean
#  listed_price     :decimal(, )
#  name             :string
#  publication_date :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  agent_id         :bigint           not null
#  seller_id        :bigint           not null
#
# Indexes
#
#  index_available_properties_on_agent_id   (agent_id)
#  index_available_properties_on_seller_id  (seller_id)
#
# Foreign Keys
#
#  fk_rails_...  (agent_id => agents.id)
#  fk_rails_...  (seller_id => sellers.id)
#
class AvailableProperty < ApplicationRecord
  # Relationships
  belongs_to :seller
  # Using a separate join model for the many-to-many relationship
  belongs_to :agent

  # Attachments
  has_one_attached :image, dependent: :destroy

  # Callers
  before_destroy :purge_image

  # Purge the attached image if any
  def purge_image
    image.purge if image.attached?
  end

  # Get the iamge URL
  def image_url
    if image.attached?
      image.url
    end
  end
end
