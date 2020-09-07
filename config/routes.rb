Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root "home#login"
  get "/about", to: "home#about"
  get "/policy", to: "home#policy"
  get "/contact", to: "home#contact"
  get "/search", to: "search#index"
  get "/search/:query/organization", to: "search#organizations", as: :organization_search_results
  get "/search/:query/user", to: "search#users", as: :user_search_results

  resources :users, only: [:show, :edit, :update] do
    member do
      get :home
      post :add_donation
      patch :update_donation
      put :update_donation
      delete :delete_donation
      post :add_favorite_cause
      delete :delete_favorite_cause
      post :add_favorite_org
      delete :delete_favorite_org
    end
  end
end
