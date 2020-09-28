require_dependency 'email/sender'
require_dependency 'sidekiq'
require_relative 'survey_mailer'

module SurveyMail
  class Survey
    include Sidekiq::Worker
    sidekiq_options queue: 'critical'

    def execute(args)
      template = args[:template]
      to_address = args[:to_address]
      survey = args[:survey]

      raise Discourse::InvalidParameters.new(:template) if template.blank?
      raise Discourse::InvalidParameters.new(:to_address) if to_address.blank?
      raise Discourse::InvalidParameters.new(:survey) if survey.blank?

      message = SurveyMailer.send_email(template, to_address, survey)
      Email::Sender.new(message, :survey).send
    end
  end
end
