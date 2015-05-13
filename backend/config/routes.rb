Rails.application.routes.draw do

  namespace :api do
    post "/search", to: "search#index"

    resources :search, except: [:new, :edit, :destroy]
  end
end
