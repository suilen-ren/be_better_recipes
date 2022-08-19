Rails.application.routes.draw do
  scope module: :user do
    root to: 'homes#top'
    get 'about' ,to: 'homes#about'
  end
  devise_for :admins, skip: [:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, skip: [:passwords],controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
