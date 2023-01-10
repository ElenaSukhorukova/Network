# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :users

    devise_scope :user do
      get 'sign_in', to: 'devise/sessions#new'
      get 'sign_up', to: 'devise/registrations#new'
      delete 'sign_out', to: 'devise/sessions#destroy'
    end

    get 'about', to: 'static_pages#about'
    get 'rules', to: 'static_pages#rules'
    get 'contacts', to: 'static_pages#contacts'

    root to: 'posts#index'

    scope module: :accounts do
      resources :accounts, shallow: true, except: %i[index show new create edit update destroy] do
        resources :friendships, only: %i[destroy]
        resources :messages, only: %i[new create]
        resources :conversations, only: %i[index show destroy]
        resources :invites, only: %i[create update]
      end
      resources :hobbies, only: %i[new create], as: 'account_hobbies'
    end

    scope module: :conversations do
      resources :conversations, shallow: true, except: %i[index show new create edit update destroy] do
        resources :messages, only: %i[create edit update destroy]
      end
    end

    shallow do
      resources :accounts do
        resources :friendships, only: %i[index destroy]
        resources :groups
      end
      resources :invites, except: %i[index show new create edit destroy] do
        resources :friendships, except: %i[index new show update destroy edit]
      end
      resources :posts do
        resources :comments, except: %i[show index]
      end
      resources :contents, except: %i[index show new create edit update destroy] do
        resources :comments, except: %i[show index]
      end
    end

    scope module: :groups do
      resources :groups, shallow: true, except: %i[index show new create edit update destroy] do
        resources :hobbies, except: %i[show index]
        resources :contents, except: %i[index]
      end
    end

    get 'account/:id/your_groups', to: 'groups#your_groups', as: 'your_groups'
    get 'account/:id/participation_groups', to: 'groups#participation_groups', as: 'participation_groups'
  end
end
# rubocop:enable Metrics/BlockLength
