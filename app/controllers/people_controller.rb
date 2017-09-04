class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = Person.actives.order('id DESC').map do |person|
      if person.type == 'NaturalPerson'
        {id:person.id, name: person.full_name, document: CPF.new(person.cpf).formatted, type: 'Pessoa física'}
      else
        {id:person.id, name: person.company_name, document: person.cnpj, type: 'Pessoa jurídica'}
      end
    end
    respond_to do |format|
      format.html
      format.json { render json: @people}
    end
  end

  def new
    @person = Person.new
  end

  def show
    if @person
      respond_to do |format|
        format.html
        format.json { render json: @person}
      end
    else
      respond_to do |format|
        format.html { redirect_to people_path, notice: "Usuário não existe" }
        format.json { head :not_found }
      end
    end
  end
  def edit; end

  def create
    @person = Person.new(people_params)
    if @person.save
      respond_to do |format|
        format.html { redirect_to people_path, notice: "Cadastro realizado com sucesso" }
        format.json { render json: @person, status: :created}
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: {errors: @person.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @person.update(people_params)
      respond_to do |format|
        format.html { redirect_to people_path, notice: "Informações atualizadas com sucesso" }
        format.json { render json: @person}
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: {errors: @person.errors } }
      end
    end
  end

  def destroy
    @person.accounts.update_all({status: 'inactive'})
    @person.update({status: 'inactive'})
    respond_to do |format|
      format.html { redirect_to people_path, notice: "Usuário excluido com sucesso" }
      format.json { head :no_content }
    end
  end

  private
    def set_person
      @person = Person.find_by(id: params[:id])
    end

    def people_params
      params[:person] = params[:natural_person] if params[:natural_person]
      params[:person] = params[:legal_person] if params[:legal_person]
      params[:person][:type] = params[:type] if params[:type] 

      params.require(:person).permit(:full_name,:cpf,:birthdate,:company_name,:trade_name,:cnpj,:type)

    end
end
