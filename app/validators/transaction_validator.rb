class TransactionValidator < ActiveModel::Validator  
  def validate(record)
    if record.transfer?
      #A conta de destino deve ser do tipo 'Branch' e ser filha de origem.
      unless record.destination.branch? && !record.origin.branches.detect{|x| x == record.destination}.nil?
        record.errors.add :destination, "Destination account isn't a branch of origin or is a MAIN account"
      end
    elsif record.contribution?
      #Aportes são relizados apenas para as matrizes e devem possuir token
      unless record.destination.main?
        record.errors.add :destination, "Destination account isn't a MAIN account"
      end
      if record.token.blank?
        record.errors.add :token, "Can't be blank"
      end
    end
  end
end