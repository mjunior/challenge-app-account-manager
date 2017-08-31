class LegalPerson < Person
  validates :cnpj, :company_name, :trade_name, presence: true
  validate :check_cnpj

  def check_cnpj
    unless CNPJ.valid?(self.cnpj)
      errors.add(:cnpj, "Invalid CNPJ")
    end
  end
end
