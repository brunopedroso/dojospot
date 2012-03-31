Dojospot::Application.routes.draw do
  
  root :to => 'home#index' 
  
  resources :dojo_sessions do
    member do
      get :confirm_presence
      get :unconfirm_presence
    end
  end
  
  resources :pages

  resources :sessions
  
  resources :users
  match 'user/edit' => 'users#edit', :as => :edit_current_user
  
  resources :history

  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login

  match 'edit_profile' => 'users#edit'
  
end
