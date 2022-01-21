class LabReport < ApplicationRecord
  belongs_to :auth_user

  validates :title, presence: true, length: { maximum: 250 }
  validates :description, length: { maximum: 250 }
end
