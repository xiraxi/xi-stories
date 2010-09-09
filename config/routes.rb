Rails.application.class.routes.draw do

  match 'stories/drafts' => 'stories#index', :draft => true, :as => "drafts_stories"

  scope "admin" do
    namespace :story do
      resources :sections
    end
  end

  resources :stories

end
