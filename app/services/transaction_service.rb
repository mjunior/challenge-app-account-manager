class TransactionService
  def self.transf origin, destination, amount
    if destination.branch? && !origin.children.detect{|x| x == destination}.nil? 
      #TODO- PROSSEGUIR
    else
      #TODO- BLOQUEAR
    end
  end
end