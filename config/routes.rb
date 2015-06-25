Rails.application.routes.draw do

  resources :report_lists do
    get :reportable, on: :collection
    get :combine, on: :member
    resources :table_lists
  end

end
