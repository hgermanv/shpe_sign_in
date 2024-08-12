Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'events/index'
  get 'events/new'
  get 'events/create'
  get 'events/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :students, only: [:index, :new, :create] do
    member do
      get :attendance
    end
  end
  resources :events, only: [:index, :new, :create, :show]  do
    member do
      get :attendees
    end
  end

  # Custom routes for specific actions if needed
  get 'students/:id/attendance', to: 'students#attendance', as: 'student_attendance'

end
