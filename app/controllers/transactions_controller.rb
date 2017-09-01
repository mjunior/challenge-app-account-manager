class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:edit]
  
  def index
    @transactions = Transaction.all
  end

  def new
    @transaction = Transaction.new
  end

  def edit; end

  def create  
    @transaction = Transaction.new(transaction_params)
    if @transaction.save()
      redirect_to transactions_path, notice: "Transação realizada com sucesso";
    else
      render :edit
    end
  end

  private
    def transaction_params
      params.require(:transaction).permit(:origin_id,:destination_id,:amount,:transaction_type)      
    end

    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
end
