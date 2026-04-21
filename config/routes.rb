Rails.application.routes.draw do
  root "rooms#index"

  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :rooms do
    resources :reservations, only: [:new, :create] do
      collection do
        post :confirm
      end
    end
  end

  #プロフィール編集用
  get "profile/edit", to: "users#edit_profile", as: :edit_profile
  patch "/profile", to: "users#update_profile", as: :profile

  #ユーザー関連
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  #施設関連
    get "my_rooms", to: "rooms#my_rooms"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
