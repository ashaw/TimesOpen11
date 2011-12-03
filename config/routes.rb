Tohack11::Application.routes.draw do
  root :to => "stations#index"
  match 'voronoi' => 'stations#voronoi'
  resources :stations, :only => [:index, :show]
  match "lines/:name" => "lines#show"
end
