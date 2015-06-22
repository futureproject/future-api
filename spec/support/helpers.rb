module IntegrationHelpers
end

RSpec.configure do |config|
  config.include IntegrationHelpers, type: :feature
  config.color_enabled = true
end

