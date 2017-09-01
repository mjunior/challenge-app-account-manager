class TransactionController < ApplicationController
  def index
    @transactions = Transaction.all
  end
end
