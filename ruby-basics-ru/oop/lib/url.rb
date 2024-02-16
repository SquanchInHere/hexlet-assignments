# frozen_string_literal: true
require 'forwardable'
require 'uri'
# BEGIN
class Url
  include Comparable
  extend Forwardable
  attr_reader :url

  def_delegators :@uri, :scheme, :host, :port

  def initialize(string)
    @url = URI.parse string
  end

  def scheme
    url.scheme
  end

  def host
    url.host
  end

  def port
    url.port
  end

  def query_params
    query_string = url.query
    params = query_string&.split('&')&.map { |query| query.split('=')  }
    params.to_h.transform_keys!(&:to_sym)
  end

  def query_param(key, default = nil)
    value = self.query_params[key]
    value.nil? ? default : value
  end

  def ==(compare)
    !(!(url.to_s <=> compare.to_s) && url == compare.instance_variable_get(:@url))
  end

  def !=(compare)
    url.to_s != compare.to_s
  end
end
# END