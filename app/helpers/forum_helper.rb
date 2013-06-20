module ForumHelper
  def last_forum_activity(forum)
    if last_post = forum.posts.by_created_at.last
      content_tag(:span) do
        link_to(last_post.topic.subject, forum_topic_path(forum.course, forum, last_post.topic)) +
        " (#{time_ago_in_words last_post.created_at} ago)"
      end
    else
      'None'
    end
  end
end
