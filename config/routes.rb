Rails.application.routes.draw do
  scope '/api/v1' do
    resources :events, only: [:index, :create, :update, :show, :destroy]
  end
end
