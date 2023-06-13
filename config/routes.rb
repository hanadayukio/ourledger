Rails.application.routes.draw do
  devise_for :user, controllers: {
    sessions: 'user/sessions',
    passwords: 'user/passwords',
    registrations: 'user/registrations'
  }
  devise_for :admin, skip: [:passwords, :registrations], controllers: {
    sessions: 'admin/sessions',
  }
    
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/' => 'user/homes#top', as: 'top_page'
  get '/admin/top' => 'admin/homes#top', as: 'admin_top_page'
  
  # 管理者台帳
  namespace :admin do
    resources :registers, path: '/registers', only: [:new, :index, :show, :edit, :update]
  end
  post 'admin/register/new' => 'admin/registers#create', as: 'create_admin_register'
  # ユーザー台帳
  namespace :user do
    resources :registers, path: '/registers', only: [:index]
  end
  
  #機器
  resources :equipments, only:[:new, :index, :show, :edit, :create, :update]
  
  
end
