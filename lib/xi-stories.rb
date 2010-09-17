
class XiStories < Rails::Engine
  config.xi_stories = ActiveSupport::OrderedOptions.new

  config.xi_stories.comments = true
  config.xi_stories.words_search = false
end
