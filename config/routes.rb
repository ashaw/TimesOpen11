Tohack11::Application.routes.draw do
  root :to => "stations#index"
  resources :stations, :only => [:index, :show]
  match "lines/:name" => "lines#show"
end
