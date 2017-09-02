class TransactionValidator < ActiveModel::Validator  
  def validate(record)
    if record.destination && record.destination.active?
      if record.transfer?
        #A conta de destino deve ser do tipo 'Branch' e ser filha de origem.
        unless record.destination.branch? && !record.origin.branches.detect{|x| x == record.destination}.nil?
          record.errors.add :destination, I18n.translate('activerecord.models.transaction.errors.not_a_branch')
        end
      elsif record.contribution?
        #Aportes são relizados apenas para as matrizes e devem possuir token
        unless record.destination.main?
          record.errors.add :destination, I18n.translate('activerecord.models.transaction.errors.not_a_main')
        end
        if record.token.blank?
          record.errors.add :token, I18n.translate('errors.messages.blank')
        end
      end
    else
      record.errors.add :destination, I18n.translate('activerecord.models.transaction.errors.not_active')
    end
  end
end