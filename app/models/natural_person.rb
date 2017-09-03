class NaturalPerson < Person
  validates :cpf, :birthdate, :full_name, presence: true
  validate :check_cpf
  def check_cpf
    unless CPF.valid?(self.cpf)
      errors.add(:cpf, "Invalid")
    end
  end
end
