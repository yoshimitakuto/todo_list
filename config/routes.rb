Rails.application.routes.draw do
  get 'searches/search'
  devise_for :users
  root to: 'homes#top'
  get 'about' => 'homes#about', as: 'about'

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :tasks do
    collection do
      get 'search'
    end
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  # get "search" => "searches#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
