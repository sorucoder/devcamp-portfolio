module SidebarTopicsConcern
  extend ActiveSupport::Concern

  def set_sidebar_topics
    @side_bar_topics = Topic.with_blogs
  end
end