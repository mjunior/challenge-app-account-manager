Rails.application.routes.draw do
  root 'transaction#index'

  resources :transaction

  scope '/api', defaults: { format: :json } do
    resources :transaction
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
