Rails.application.routes.draw do
  devise_for :users
  get "home/index"
  root to: "home#index"

  resources :cut_yields, only: [:show , :index, :new, :create] do
    collection do
      post :calculate
    end
  end

  resources :miter_frames, only: [:index, :new, :create] do
    collection do
      post :calculate
    end
  end

  resources :projects
  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get("/your_first_screen", { :controller => "pages", :action => "first" })
end
