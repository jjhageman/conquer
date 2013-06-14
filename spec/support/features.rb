RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Features::Wysihtml5Helpers, type: :feature
end
