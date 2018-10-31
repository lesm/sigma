require_relative "features/session_helper"
RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
end
