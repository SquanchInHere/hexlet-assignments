# frozen_string_literal: true

Rails.application.routes.draw do
  mount Blog::Engine => '/blog'
  mount RailsStats::Engine => '/stats'

  scope module: :web do
    root 'home#index'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
