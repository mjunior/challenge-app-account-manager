require 'rails_helper'

RSpec.describe 'People API', type: :request do
  let!(:headers) { {'Content-Type' => Mime[:json].to_s } }

  # describe 'GET /api/transactions' do
  #   context "Ver listagem de transações" do
  #     before(:each) do
  #       FactoryGirl.create_list(:natural_person, 5)
  #       FactoryGirl.create_list(:legal_person, 5)
  #       get "/api/people", params: {}, headers: headers
  #     end
  #     it { expect(response).to be_success }
  #     it { expect(json_body.size).to eq(10) }
  #   end
  # end
  
  # describe 'GET /api/people/:id' do
  #   let!(:person){ FactoryGirl.create(:natural_person) }
  #   let!(:person_id){ person.id }
    
  #   before do
  #     get "/api/people/#{person_id}", params: {}, headers: headers
  #   end

  #   context 'Quando a pessoa existe' do
  #     it 'Retorna a pessoa' do
  #       expect(json_body[:id]).to eq(person_id)
  #     end

  #     it 'A Requisição retorna OK (200)' do
  #       expect(response).to have_http_status(:ok)
  #     end
  #   end

  #   context 'Quando o usuário NÃO existe' do
  #     let!(:person_id){ 9000 }
  #     it 'A Requisição retorna NOT_FOUND (404)' do
  #       expect(response).to have_http_status(:not_found)
  #     end
  #   end
  # end

  # describe 'POST /api/people' do
  #   before do
  #     post '/api/people', params: {person: person_params}.to_json, headers: headers
  #   end

  #   context 'Quando os dados da pessoa estão corretos' do
  #     let(:person_params){ FactoryGirl.attributes_for(:natural_person) }
  #     it 'Esperamos código 201, :created' do
  #       expect(response).to have_http_status(:created)
  #     end

  #     it 'Retorna o JSON do usuário cadastrado' do
  #       expect(json_body[:cpf]).to eq(person_params[:cpf])
  #     end
  #   end

  #   context 'Quando os dados da pessoa NÂO estão corretos' do
  #     let(:person_params){ FactoryGirl.attributes_for(:natural_person, cpf: "invalid_cpf") }
   
  #     it 'Esperamos código 401, :unprocessable_entity' do
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
      
  #     it 'Retorna mensagens de errors' do
  #      expect(json_body).to have_key(:errors)
  #     end
  #   end
  # end

  # describe 'DELETE /api/people/:id' do
  #   let!(:person){ FactoryGirl.create(:natural_person)}

  #   before do
  #     delete "/api/people/#{person.id}", params: {}, headers: headers
  #   end

  #   it 'Esperamos código 401, :no_content' do
  #     expect(response).to have_http_status(:no_content)
  #   end
  # end

end