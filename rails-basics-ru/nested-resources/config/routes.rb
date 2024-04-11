# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'

  resources :posts do
    resources :comment, only: %i[index new create]
  end

  resources :posts, except: [:index] do
    resources :comment, only: %i[show edit update destroy]
  end
end
