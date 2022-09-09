Rails.application.routes.draw do

  devise_for :admins, skip: [:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, skip: [:passwords],controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions"
  }
  devise_scope :user do
    get 'users/guest_sign_in', to: "user/sessions#guest_sign_in"
  end

  scope module: :user do
    get 'search', to: "recipes#search"
    root to: 'homes#top'

    resources :tags ,only: [:show]

    get 'about' ,to: 'homes#about'
    resources :recipes do
      resource :favorites, only: [:create,:destroy]
      resources :comments, only: [:create,:destroy]
    end
    resource :mypages ,except: [:new, :destroy] do
      get 'recipes', to: 'mypages#recipes'
      get 'confirm', to: 'mypages#confirm'
      patch 'withdraw', to: 'mypages#withdraw'
      resource :goals ,only: [:show , :update]
      get 'favorite', to: "mypages#favorite"
    end
    get 'tips/about_diet', to: 'tips#about_diet'
  end

  namespace :admin do
    resources :recipes , except: [:edit, :new, :create] do
      resources :comments ,only: [:index, :destroy]
    end
    resources :users ,except: [:new,:create,:destroy] do
      get 'recipes' ,to: 'users#recipes'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
