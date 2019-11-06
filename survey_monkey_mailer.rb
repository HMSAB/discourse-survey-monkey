require 'email'
require 'email/build_email_helper'

class SurveyMonkeyMailer < ActionMailer::Base

  def send_email(template, to_address, survey)
    build_email(
      to_address,
      template: template,
      survey: survey
    )
  end
end
