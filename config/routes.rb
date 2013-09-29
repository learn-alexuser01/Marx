Marx::Application.routes.draw do
  resources :pages, only: [:create, :update, :delete, :show]
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", sessions: "users/sessions" }
  root :to => "home#index"
end
