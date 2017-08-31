class Account < ApplicationRecord
  enum status: [:inactive, :active]

  belongs_to :person
  belongs_to :parent, foreign_key: "parent_id", class_name: "Account", optional: true
  has_many :branches, foreign_key: "parent_id", class_name: "Account", dependent: :delete_all

  def main?
    self.type.downcase == 'main'
  end

  def branch?
    self.type.downcase == 'branch'
  end
end
