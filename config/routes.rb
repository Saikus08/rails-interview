Rails.application.routes.draw do
  namespace :api do
    resources :todo_lists, only: %i[index show create destroy], path: :todolists do
      resources :todo_items
    end
  end

  resources :todo_lists, only: %i[index new], path: :todolists
end
