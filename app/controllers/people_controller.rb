class PeopleController < ApplicationController
  def index
    @people = Person.all.map do |person|
      if person.type == 'NaturalPerson'
        {id:person.id, name: person.full_name, document: CPF.new(person.cpf).formatted, type: 'Pessoa física'}
      else
        {id:person.id, name: person.company_name, document: person.cnpj, type: 'Pessoa jurídica'}
      end
    end
  end

  def new; end
end
