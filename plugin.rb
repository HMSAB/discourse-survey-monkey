enabled_site_setting :survey_monkey_enabled

after_initialize do
  DiscourseEvent.on(:accepted_solution) do |topic, post, user|
    solved_topic = Topic.find_by(id: topic.topic_id)
    original_poster = User.find_by(id: solved_topic.user_id)
  end
end
