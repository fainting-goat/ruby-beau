Rails.application.routes.draw do
  resources :dogs
  root to: 'pages#home'
end
