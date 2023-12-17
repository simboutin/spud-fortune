Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :potato_share_prices, only: :index
    end
  end
end
