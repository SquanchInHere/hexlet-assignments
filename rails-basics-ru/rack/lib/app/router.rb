# frozen_string_literal: true

require 'rack'

class Router
  def call(env)
    request = Rack::Request.new(env)
    path = request.path

    if path == '/'
      [200, {}, 'Hello, World!']
    elsif path == '/about'
      [200, {}, 'About page']
    else
      [404, {}, '404 Not Found']
    end
  end
end
