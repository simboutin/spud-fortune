Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :potato_share_prices, only: :index do
        collection { get 'max_potential_gain', to: 'potato_share_prices#max_potential_gain' }
      end
    end
  end
end
