require_dependency 'email/message_builder'

class SurveyMonkeyMailer < ActionMailer::Base
  include Email::BuildEmailHelper

  def send_email(template, to_address, survey)
    build_email(
      to_address,
      template: template,
      survey: survey
    )
  end
end
