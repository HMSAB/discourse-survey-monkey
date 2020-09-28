# name: survey
# about: Send an email containing a survey upon topic solved
# version: 0.1
# authors: HMS Solution Center Americas
# url: https://github.com/hms-networks/discourse-survey

require_relative 'survey_mail'
enabled_site_setting :survey_monkey_enabled

after_initialize do
  load File.expand_path("../controllers/survey_monkey_controller.rb", __FILE__)

  Discourse::Application.routes.prepend do
   post 'surveymonkey/send_survey' => 'surveymonkey#send_survey'
  end

  Topic.register_custom_field_type('survey_sent', :boolean)
  add_to_serializer(:topic_view, :custom_fields, false) {object.topic.custom_fields}

  DiscourseEvent.on(:accepted_solution) do |topic, post, user|
    solved_topic = Topic.find_by(id: topic.topic_id)
    if solved_topic.custom_fields["survey_sent"] == false || solved_topic.custom_fields["survey_sent"].nil?
      @user = nil
      if !solved_topic.custom_fields["phone_survey_recipient"].nil?
        @user = User.find_by(username: solved_topic.custom_fields["phone_survey_recipient"].to_s)
      else
        @user = User.find_by(id: solved_topic.user_id)
      end
      survey = SiteSetting.survey_monkey_survey_url.to_s
      url = survey.sub('%{topic_id}', solved_topic.id.to_s)
      SurveyMail::Survey.new.execute(template: 'survey_monkey', to_address: @user.email, survey: url)
      solved_topic.custom_fields["survey_sent"] = true;
      solved_topic.save!
    end
  end
end
