class Person < ApplicationRecord
  enum status: [:active, :inactive]

  scope :actives, -> { where(status: 0) }

  has_many :accounts

  validates :type, presence: true

  def name
    self.full_name.blank? ? self.company_name : self.full_name
  end

end
