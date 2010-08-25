
class XiStories < Rails::Engine
  config.xi_stories = ActiveSupport::OrderedOptions.new

  config.xi_stories.comments = true
end
