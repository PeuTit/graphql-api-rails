# frozen_string_literal: true

HealthCheck.setup do |config|
  # Text output upon success
  config.success = 'Hello!'

  # Standard checks
  config.standard_checks = %w[database migrations cache]
end
