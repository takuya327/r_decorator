Dummy::Application.routes.draw do
  resources :authors, :only => [:index, :show] do
    resources :books, :only => :show
  end
end
