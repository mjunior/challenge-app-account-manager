class Person < ApplicationRecord
  enum status: [:active, :inactive]

  scope :actives, -> { where(status: 0) }

  has_many :accounts
end
