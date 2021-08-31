Rails.application.routes.draw do
  # Point root to health check
  root to: 'health_check/health_check#index'

  post "/graphql", to: "graphql#execute"
end
