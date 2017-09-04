class AccountsController < ApplicationController
  before_filter :set_account, only: [:show, :edit, :update, :destroy]
  
  def index
    @accounts = Account.actives.order('id DESC')
    respond_to do |format|
      format.html
      format.json{ render json: @accounts }
    end
  end

  def new
    @account = Account.new
  end

  def show
    @transactions_input = Transaction.where("destination_id = :account",{account: @account.id })
    @transactions_output = Transaction.where("origin_id = :account",{account: @account.id })
    respond_to do |format|
      format.html
      format.json { render json: {account: @account, transactions_input:@transactions_input, transactions_output:@transactions_output} }
    end
  end

  def destroy
    @account.update({status: 'inactive'})
    respond_to do |format|
      format.html{ redirect_to accounts_path, notice: 'Conta desativada com sucesso' }
      format.json { head :no_content }
    end    
  end

  def edit; end

  def update
    if @account.update(account_params)
      respond_to do |format|
        format.html { redirect_to account_path(@account) }
        format.json { render json: @account }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: {errors: @account.errors} }
      end
    end
  end
  
  def create
    @account = Account.new(account_params)
    if @account.save
      respond_to do |format|
        format.html { redirect_to accounts_path, notice: 'Conta criada com sucesso' }
        format.json { render json: @account }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: {errors: @account.errors }}
      end
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
