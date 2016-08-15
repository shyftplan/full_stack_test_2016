Rails.application.routes.draw do
  resources :events do
    patch :sort
  end
  root to: 'events#index'
end
