# frozen_string_literal: true

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    start_time = Time.now
    end_time = Time.now
    headers['X-Execution-Time'] = ((end_time - start_time) * 1_000_000).to_s
    [status, headers, body]
  end
end
