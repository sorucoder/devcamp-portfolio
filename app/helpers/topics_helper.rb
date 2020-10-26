module TopicsHelper
  def sidebar_topic_helper(topic)
    if current_page?(topic_path(topic))
      link_to topic.title, '#', class: "active" 
    else
      link_to topic.title, topic_path(topic)
    end
  end
end
