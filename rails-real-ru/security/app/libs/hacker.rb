# frozen_string_literal: true

require 'open-uri'
require 'net/http'
require 'nokogiri'

class Hacker
  BLOG_URL = 'https://rails-collective-blog-ru.hexlet.app'

  class << self
    def hack(email, password)
      reg_action = 'users'
      reg_page_action = 'users/sign_up'
      uri = URI(BLOG_URL)
      http = get_http(uri)
      request = Net::HTTP::Get.new URI.join(BLOG_URL, reg_page_action)
      response = http.request request
      html = get_html(response.body)
      csrf_token = get_auth_token html
      cookies = get_cookie response.response['set-cookie']

      params = {
        'user[email]': email,
        'user[password]': password,
        'user[password_confirmation]': password,
        authenticity_token: csrf_token
      }

      request = Net::HTTP::Post.new URI.join(BLOG_URL, reg_action)
      request.body = URI.encode_www_form(params)
      request['Cookie'] = cookies

      response = http.request request
      response.code == '302'
    end

    private

    def get_http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end

    def get_html(body)
      Nokogiri::HTML(body)
    end

    def get_cookie(cookies)
      cookies.split('; ').first
    end

    def get_auth_token(html)
      html.at('input[@name="authenticity_token"]')['value']
    end
  end
end
