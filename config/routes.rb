BlockWeb::Application.routes.draw do

  resources :block_changes

  root :to => 'block_changes#index'

end
