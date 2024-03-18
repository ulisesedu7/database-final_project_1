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
class AuditLog < ApplicationRecord
  # Relationships
  belongs_to :record, polymorphic: true
  belongs_to :user

  # Validations
  validates :action, presence: true, length: { maximum: 100 }
  validates :record_type, presence: true, length: { maximum: 100 }
  validates :record_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :details, presence: true, length: { maximum: 1000 }
end
