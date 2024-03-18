# == Schema Information
#
# Table name: sold_properties
#
#  id               :bigint           not null, primary key
#  address          :string
#  agent_commission :decimal(, )
#  bedrooms         :integer
#  city             :string
#  has_pool         :boolean
#  name             :string
#  sale_date        :date
#  sale_price       :decimal(, )
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  agent_id         :bigint           not null
#  buyer_id         :bigint           not null
#  seller_id        :bigint           not null
#
# Indexes
#
#  index_sold_properties_on_agent_id   (agent_id)
#  index_sold_properties_on_buyer_id   (buyer_id)
#  index_sold_properties_on_seller_id  (seller_id)
#
# Foreign Keys
#
#  fk_rails_...  (agent_id => agents.id)
#  fk_rails_...  (buyer_id => buyers.id)
#  fk_rails_...  (seller_id => sellers.id)
#
require "test_helper"

class SoldPropertyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
