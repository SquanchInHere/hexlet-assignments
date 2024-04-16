# frozen_string_literal: true

require 'test_helper'

class SetLocaleMiddlewareTest < ActionDispatch::IntegrationTest
  def setup
    app = ->(env) { [200, env, 'app'] }

    @middleware = SetLocaleMiddleware.new(app)
  end

  test 'switch to en' do
    env = env_for('http://localhost',
                  'HTTP_ACCEPT_LANGUAGE' => 'en,ru;q=0.9,en-US;q=0.8')
    @middleware.call env

    assert { I18n.locale == :en }
  end

  test 'switch to ru' do
    env = env_for('http://localhost',
                  'HTTP_ACCEPT_LANGUAGE' => 'ru,en;q=0.9,en-US;q=0.8')
    @middleware.call env

    assert { I18n.locale == :ru }
  end

  def env_for(url, opts = {})
    Rack::MockRequest.env_for(url, opts)
  end
end
