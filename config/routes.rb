Rails.application.class.routes.draw do

  namespace :story do resources :sections end

  resources :stories

end
