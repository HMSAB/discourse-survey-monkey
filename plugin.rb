# name: survey-monkey
# about: Searchable private category topics
# version: 0.1
# authors: Jordan Seanor
# url: https://github.com/HMSAB/discourse-hms-phone-tracking.git

require_relative 'survey_mail'
enabled_site_setting :survey_monkey_enabled

after_initialize do
  DiscourseEvent.on(:accepted_solution) do |topic, post, user|
    solved_topic = Topic.find_by(id: topic.topic_id)
    original_poster = User.find_by(id: solved_topic.user_id)
    survey = SiteSetting.survey_monkey_survey_url.to_s
    puts "SURVSSS"
    puts survey
    url = survey.sub('%{topic_id}', solved_topic.id.to_s)
    puts "SURVEY YOO"
    puts url
    SurveyMail::Survey.new.execute(template: 'survey_monkey', to_address: original_poster.email, survey: url)
  end
end
