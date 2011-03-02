Ticketee::Application.routes.draw do
  get "ticket/show"

  get "users/index"

  devise_for :users

  resources :assets

 root :to => "projects#index"
 resources :projects do
    resources :tickets
  end

  resources :tickets do
    resources :comments
  end

  namespace :admin do
    root :to => "base#index"
    resources :users do
      resources :permissions
    end
  end

  match '/admin/users/:user_id/permissions', :to => 'admin/permissions#update', :as => :update_user_permissions
end

