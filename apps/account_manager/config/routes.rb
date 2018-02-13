Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications,
                     :authorized_applications
  end
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :accounts, only: [:show, :create, :index] do
    get :user_accounts
  end

  scope :transfers do
    post :charge_account, to: 'transfers#charge_account'
    post :transfer, to: 'transfers#transfer'
    post :cash_back, to: 'transfers#cash_back'
  end
end
