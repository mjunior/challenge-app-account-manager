class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:edit, :show]
  
  def index
    @transactions = Transaction.all
  end

  def new
    @transaction = Transaction.new
  end

  def edit; end

  def show; end

  def create  
    @transaction = Transaction.new(transaction_params)
    if @transaction.save()
      redirect_to transactions_path, notice: "Transação realizada com sucesso";
    else
      render :new
    end
  end

  def reversal
    token = params[:transaction_token].blank? ? nil : params[:transaction_token]
    transaction = Transaction.find_by(id: params[:id],
                                      token: token)
                                      byebug
    if transaction
      Transaction.create(origin: transaction.destination,
                        destination: transaction.origin,
                        amount: transaction.amount,
                        transaction_type: 'reversal');

      redirect_to transactions_path, notice: "Estorno realizado com sucesso";
    else
      #do something
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
