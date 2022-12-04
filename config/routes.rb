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
  
  scope module: :accounts do
    resources :accounts, except: %i[index show new create edit update destroy] do
      resources :messages, only: %i[new create]
      resources :conversations, only: %i[index show destroy]
      resources :posts
      resources :interests
      resources :invites, only: %i[create update]
    end
  end

  scope module: :conversations do
    resources :conversations, shallow: true, except: %i[index show new create edit update destroy] do
      resources :messages, only: %i[create edit update destroy]
    end
  end

  shallow do 
    resources :users do 
      resource :account
    end
    resources :accounts do   
      resources :friendships, only: %i[index]
      resources :groups
    end
    resources :invites, except: %i[index show new create edit destroy] do 
      resources :friendships, except: %i[index new show update destroy edit]
    end
    resources :posts do
      resources :comments, except: %i[show index]
    end
  end

  get 'friendships/invites', to: 'friendships#invites', as: 'invites_page'
end
