Rails.application.routes.draw do
  apipie
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :projects do
        resources :tasks do
          resources :comments
        end
      end
      post 'auth/login', to: 'authentication#authenticate'
      post '/signup', to: 'users#create'
    end
  end
end
