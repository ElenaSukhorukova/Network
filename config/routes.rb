Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do  
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
    get 'sign_out', to: 'devise/sessions#destroy'
  end

  get 'about', to: 'static_pages#about'
  get 'rules', to: 'static_pages#rules'
  get 'contacts', to: 'static_pages#contacts'

  root to: "posts#index"
  resources :posts, only: %i[index]

  shallow do 
    resources :users do 
      resource :account
    end
    resources :accounts do
      resources :posts
      resources :conversations
      resources :friendships
      resources :groups
      resources :invites, only: %i[create destroy]
    end
    resources :posts do
      resources :comments
    end
    resources :friendships do 
      resource :invite
    end
    resources :conversation do 
      resources :messages
    end
  end
end
