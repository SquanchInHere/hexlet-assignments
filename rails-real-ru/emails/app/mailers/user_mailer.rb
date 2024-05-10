# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation
    @user = params[:user]
    @url = 'http://example.com'

    mail(
      to: email_address_with_name(@user.email, @user.name),
      subject: t('subject')
    )
  end
end
