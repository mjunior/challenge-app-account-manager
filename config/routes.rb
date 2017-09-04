Rails.application.routes.draw do
 

  root 'transactions#index'
  resources :accounts
  resources :accounts, as: 'mains'
  resources :accounts, as: 'branches'
  resources :people
  resources :people, as: 'natural_people'
  resources :people, as: 'legal_people'
  resources :transactions, except: [:destroy, :edit, :update]

  post '/transactions/:id/reversal', to: 'transactions#reversal', as: 'transaction_reversal'

  # API
  scope '/api', defaults: { format: :json } do
    resources :transactions, except: [:destroy, :edit, :update]
    resources :people

    post '/transactions/:id/reversal', to: 'transactions#reversal', as: 'api_transaction_reversal'
  end

end
