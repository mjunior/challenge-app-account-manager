class AccountsController < ApplicationController
  before_filter :set_account, only: [:show, :edit, :update, :destroy]
  
  def index
    @accounts = Account.actives
  end

  def new
    @account = Account.new
  end

  def show
    @transactions_input = Transaction.where("destination_id = :account",{account: @account.id })
    @transactions_output = Transaction.where("origin_id = :account",{account: @account.id })
  end

  def destroy
    @account.update({status: 'inactive'})
    redirect_to accounts_path, notice: 'Conta desativada com sucesso'
  end


  def edit; end

  def update
    @account.update(account_params)
    redirect_to account_path(@account)
  end
  
  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to accounts_path, notice: 'Conta criada com sucesso'
    else
      render :new
    end
  end



  private
    def account_params
      params[:account] = params[:main] if params[:main]
      params[:account] = params[:branch] if params[:branch]
      
      params.require(:account).permit(:name, :type, :person_id, :parent_id)
    end

    def set_account
      @account = Account.find(params[:id])
    end
end
