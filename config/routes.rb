require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'

  get 'job/submit/:who/:message', to: 'job#submit'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :applications do
        member do
          resources :chats
        end
      end
    end
  end
end
