# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    locale = extract_locale_from_header(env)
    locale ||= I18n.default_locale.to_s
    locale = available_locale(locale) || I18n.default_locale.to_s

    I18n.with_locale(locale) do
      @app.call(env)
    end
  end

  private

  def extract_locale_from_header(env)
    return nil if env['HTTP_ACCEPT_LANGUAGE'].nil?

    env['HTTP_ACCEPT_LANGUAGE'].split(',').map { |tag| tag.split(';').first }.first
  end

  def available_locale(locale)
    I18n.available_locales.map(&:to_s).include?(locale) ? locale : nil
  end
end
