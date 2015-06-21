Rails.application.routes.draw do

  resources :report_lists do
    resources :table_lists
  end

end
