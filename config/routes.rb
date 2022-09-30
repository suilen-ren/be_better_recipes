Rails.application.routes.draw do

  devise_for :admin, skip: [:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :user, skip: [:passwords],controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions"
  }
  devise_scope :user do
    get 'users/guest_sign_in', to: "user/sessions#guest_sign_in"
  end


  scope module: :user do

    root to: 'homes#top'

    resources :tags ,only: [:show]

    get 'about' ,to: 'homes#about'
    resources :recipes do
      resource :favorites, only: [:create,:destroy]
      resources :comments, only: [:create,:destroy]
    end
    get 'search', to: "recipes#search"
    resource :mypages ,except: [:new, :destroy] do
      get 'recipes', to: 'mypages#recipes'
      get 'confirm', to: 'mypages#confirm'
      patch 'withdraw', to: 'mypages#withdraw'
      resource :goals ,only: [:show , :update]
      get 'favorite', to: "mypages#favorite"
      resources :bodyweights ,only: [:update]
    end
    get 'tips/about_diet', to: 'tips#about_diet'
    post 'tips/about_diet', to: 'tips#about_diet'
  end

  namespace :admin do
    root to: "recipes#index"
    resources :users ,onlu: [:index,:show,:update] do
      get 'recipe', to: 'users#recipe'
    end
    resources :recipes , except: [:index,:edit, :new, :create] do
      resources :comments ,only: [:index, :destroy]
    end
    get "/recipe/search", to: "recipes#search"
    resources :users ,except: [:new,:create,:destroy] do
      get 'recipes' ,to: 'users#recipes'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
