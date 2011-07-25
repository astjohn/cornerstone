Cornerstone::Engine.routes.draw do

  resources :discussions

  root :to => "help#index"

end

