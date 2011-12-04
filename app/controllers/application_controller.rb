class ApplicationController < ActionController::Base
  protect_from_forgery
  caches_page :show, :index
end
