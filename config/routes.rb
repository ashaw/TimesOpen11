Tohack11::Application.routes.draw do
  root :to => "lines#index"
  match 'voronoi' => 'stations#voronoi'
  resources :stations, :only => [:index, :show]
  match "lines" => "lines#index"
  match "lines/:name" => "lines#show"
end
