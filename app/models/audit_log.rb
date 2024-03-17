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
class AuditLog < ApplicationRecord
  # Relationships
  belongs_to :record, polymorphic: true

  # Validations
  validates :action, presence: true, length: { maximum: 100 }
  validates :record_type, presence: true, length: { maximum: 100 }
  validates :record_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :details, presence: true, length: { maximum: 1000 }
end
