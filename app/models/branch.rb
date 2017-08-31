class Branch < Account
  validates :parent, presence: true
end
