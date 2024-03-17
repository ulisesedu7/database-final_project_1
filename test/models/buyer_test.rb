# == Schema Information
#
# Table name: buyers
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class BuyerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
