require 'email'
require 'email/build_email_helper'

class SurveyMailer < ActionMailer::Base
  include Email::BuildEmailHelper

  def send_email(template, to_address, survey)
    build_email(
      to_address,
      template: template,
      survey: survey
    )
  end
end
