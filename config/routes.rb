require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :applications do
        resources :chats do
          resources :messages do
            collection do
              get 'search', to: 'search#search'
            end
          end
        end
      end
    end
  end
end
