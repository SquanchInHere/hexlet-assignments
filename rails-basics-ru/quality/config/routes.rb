# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  resources :bulletins, only: %i[index show]
end
