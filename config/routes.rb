Cornerstone::Engine.routes.draw do

  resources :discussions
  resources :categories

  root :to => "help#index"

end

