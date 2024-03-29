Rails.application.routes.draw do
  resources :sold_properties
  resources :available_properties
  resources :sellers
  resources :buyers
  resources :agents
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path as '/' the home page
  root to: "home#index"

  # Reports path
  get "reports" => "home#reports", as: :reports

  # audit_logs path
  get "audit_logs" => "home#audit_logs", as: :audit_logs

  # Mount LetterOpenerWeb in development environment
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
