class PeopleController < ApplicationController
  before_filter :set_person, only: [:show]

  def index
    @people = Person.all.reverse.map do |person|
      if person.type == 'NaturalPerson'
        {id:person.id, name: person.full_name, document: CPF.new(person.cpf).formatted, type: 'Pessoa física'}
      else
        {id:person.id, name: person.company_name, document: person.cnpj, type: 'Pessoa jurídica'}
      end
    end
  end

  def new
    @person = Person.new
  end

  def show;  end

  def create
    @person = Person.new(people_params)
    if @person.save
      redirect_to people_path, notice: "Cadastro realizado com sucesso"
    else
      render :new
    end
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def people_params
      params[:person] = params[:natural_person] if params[:natural_person]
      params[:person] = params[:legal_person] if params[:legal_person]
      params[:person][:type] = params[:type] 

      if params[:type] == 'NaturalPerson'
        params.require(:person).permit(:full_name,:cpf,:birthdate,:type)      
      elsif params[:type] == 'LegalPerson'
        params.require(:person).permit(:company_name,:trade_name,:cnpj,:type)
      end
    end
end
