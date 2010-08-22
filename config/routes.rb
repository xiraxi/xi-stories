Rails.application.class.routes.draw do

  match 'stories/drafts' => 'stories#index', :draft => true, :as => "drafts_stories"

  namespace :story do resources :sections end

  resources :stories

end
