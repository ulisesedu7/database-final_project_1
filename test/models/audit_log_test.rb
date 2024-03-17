# == Schema Information
#
# Table name: audit_logs
#
#  id          :bigint           not null, primary key
#  action      :string
#  details     :text
#  record_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  record_id   :integer
#
require "test_helper"

class AuditLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
