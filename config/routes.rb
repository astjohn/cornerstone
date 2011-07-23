Rails.application.routes.draw do
  get "tester/index"

  resources :discussions

end

