require 'rails_helper'

RSpec.describe 'People API', type: :request do
  let!(:headers) { {'Content-Type' => Mime[:json].to_s } }

  describe 'GET /api/transactions' do
    context "Ver listagem de transações" do
      before(:each) do
        main = FactoryGirl.create(:main_with_branches)
        FactoryGirl.create(:transaction, origin_account: main, destination_account: main.branches.first, type: 'transfer')
        FactoryGirl.create(:transaction, destination_account: main, origin_account: main.branches.first, type: 'contribution')
        get "/api/transactions", params: {}, headers: headers
      end
      it { expect(response).to be_success }
      it { expect(json_body.size).to eq(2) }
    end
  end
  
  describe 'POST /api/transactions ' do
    before do
      post '/api/transactions', params: {transaction: transaction_params}.to_json, headers: headers
    end

    context 'Quando é uma transferencia valida' do
      let(:main){ FactoryGirl.create(:main_with_branches) }

      let(:transaction_params){ FactoryGirl.attributes_for(:transaction, origin_account: main, destination_account: main.branches.first, type: 'transfer') }

      it 'Esperamos código 200, :ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'Quando é uma transferencia invalida' do
      let(:main){ FactoryGirl.create(:main_with_branches) }
      let(:transaction_params){ FactoryGirl.attributes_for(:transaction, destination_account: main, origin_account: main.branches.first, type: 'transfer') }

      it 'Retorna mensagens de errors' do
        expect(json_body).to have_key(:errors)
      end
    end

    context 'Quando é uma APORTE valido' do
      let(:main){ FactoryGirl.create(:main_with_branches) }
      let(:transaction_params){ FactoryGirl.attributes_for(:transaction, destination_account: main, origin_account: main.branches.first, type: 'contribution') }

      it 'Esperamos código 200, :ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'Quando é uma APORTE invalida' do
      let(:main){ FactoryGirl.create(:main_with_branches) }

      let(:transaction_params){ FactoryGirl.attributes_for(:transaction, origin_account: main, destination_account: main.branches.first, type: 'contribution') }
      it 'Retorna mensagens de errors' do
        expect(json_body).to have_key(:errors)
      end
    end

    # context 'Quando os dados da pessoa NÂO estão corretos' do
    #   let(:person_params){ FactoryGirl.attributes_for(:natural_person, cpf: "invalid_cpf") }
   
    #   it 'Esperamos código 401, :unprocessable_entity' do
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end
      
    #   it 'Retorna mensagens de errors' do
    #    expect(json_body).to have_key(:errors)
    #   end
    # end
  end

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