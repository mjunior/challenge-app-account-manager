class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show]
  
  def index
    @transactions = Transaction.order('id DESC')
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @transactions}
    end
  end

  def new
    @transaction = Transaction.new
  end

  def show; end

  def create  
    @transaction = Transaction.new(transaction_params)
    if @transaction.save()
      respond_to do |format|
        format.html { redirect_to transactions_path, notice: "Transação realizada com sucesso"; }
        format.json { render json: @transaction}
      end
    else
       respond_to do |format|
        format.html { render :new }
        format.json { render json: { errors: @transaction.errors}}
      end
    end
  end

  def reversal
    token = params[:transaction_token].blank? ? nil : params[:transaction_token]
    transaction = Transaction.find_by(id: params[:id], token: token)   
                               
    if transaction && transaction.reversal?
      respond_to do |format|
        format.html { redirect_to transactions_path, alert: "Não é possivel cancelar um estorno." }
        format.json { render json: { errors: 'Não é possivel cancelar um estorno.'} }
      end
    elsif transaction && transaction.canceled?
      respond_to do |format|
        format.html { redirect_to transactions_path, alert: "Transação já estornada" }
        format.json { render json: { errors: 'Transação já estornada'} }
      end  
    elsif transaction && !transaction.reversal? && !transaction.canceled?  
      transaction_reversal = Transaction.create(origin: transaction.destination,
                                                destination: transaction.origin,
                                                amount: transaction.amount,
                                                transaction_type: 'reversal');
      transaction.status = 'canceled'
      transaction.save()
      respond_to do |format|
        format.html { redirect_to transactions_path, notice: "Estorno realizado com sucesso" }
        format.json { render json: transaction_reversal }
      end
    elsif !transaction
      respond_to do |format|
        format.html { redirect_to transactions_path, alert: "Código de Autorização inválido. Entre em contato"; }
        format.json { render json: { errors: 'Código de Autorização inválido. Entre em contato'} }
      end
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
