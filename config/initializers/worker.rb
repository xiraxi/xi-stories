
if XiStoriesWorker::Application === Rails.application
  XiStoriesWorker::Application.config.secret_token = 'ab3f5b274931cedf11552e71d8d3f9b76ba5a8293937cbfe3d70ab1aeb501d94368d2f7ae782d0ae92f283b57069f6d46b5e1174cd0813eb2c024694d07cc0b5'
  XiStoriesWorker::Application.config.session_store :cookie_store, :key => '_xi_stories_worker_session'
end
