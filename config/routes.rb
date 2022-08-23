Rails.application.routes.draw do

    devise_for :admins, skip: [:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, skip: [:passwords],controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions"
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: "user/sessions#guest_sign_in"
  end

  scope module: :user do
    root to: 'homes#top'
    get 'about' ,to: 'homes#about'
    resources :recipes do
      resources :favorite , only: [:create,:destroy]
    end
    resource :mypages ,except: [:new, :destroy, :create] do
      get 'recipes', to: 'mypages#recipes'
      get 'confirm', to: 'mypages#confirm'
      patch 'withdraw', to: 'mypages#withdraw'
      resource :goal ,only: [:show ,:create, :update]
      get 'favorite', to: "favorite#index"
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
