# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    hash = Digest::SHA2.new(256).hexdigest body
    [status, headers, "#{body}\n#{hash}"]
  end
end
