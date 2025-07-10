# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'x_clone@example.com'
  layout 'mailer'
end
