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
#  user_id     :bigint           not null
#
# Indexes
#
#  index_audit_logs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class AuditLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
