module ApplicationHelper
  def get_record()
    model = controller_name.classify.constantize
    model.find(params[:id])
  end

  def friendly_source_name(source)
    sources = {
      "facebook" => "Facebook",
      "twitter" =>  "Twitter",
      "github" => "GitHub"
    }
    if sources.key?(source)
      sources[source]
    else
      "the Internet" # What else could it be?
    end
  end

  def like_color_helper(votable)
    if current_user.voted_for?(votable) && current_user.liked?(votable)
      "color: blue;"
    else
      "color: gray;"
    end
  end

  def dislike_color_helper(votable)
    if current_user.voted_for?(votable) && current_user.disliked?(votable)
      "color: red;"
    else
      "color: gray;"
    end
  end

  def source_helper(tag_classes)
    if session[:source]
      greeting = "Thanks for visiting me from #{friendly_source_name(session[:source])}! Please feel free to #{link_to("contact me", contact_path)} to get in touch about future oppurtunities and the like!"
      content_tag(:div, greeting.html_safe, class: tag_classes)
    end
  end

  def copyright_helper
    SorucoderViewTool::Renderer.copyright('Marcus "SoruCoder" Germano, IV', 'All rights reserved.')
  end

  def nav_items
    [
      {
        url: root_path,
        title: 'Home'
      },
      {
        url: about_me_path,
        title: 'About Me'
      },
      {
        url: contact_path,
        title: 'Contact'
      },
      {
        url: tech_news_path,
        title: 'Tech News'
      },
      {
        url: blogs_path,
        title: 'Blogs'
      },
      {
        url: portfolios_path,
        title: 'Portfolio'
      }
    ]
  end

  def nav_helper(tag_classes, parent_tag: nil)
    nav_links = ''
    
    if parent_tag.nil?
      # Normal navigation links
      nav_items.each do |item|
        nav_links << "<a href=\"#{item[:url]}\" class=\"#{tag_classes} #{active?(item[:url])}\">#{item[:title]}</a>"
      end

      # Devise links
      if current_user.is_a?(GuestUser)
        nav_links << "<a href=\"#{new_user_registration_path}\" class=\"#{tag_classes}\">Sign Up</a>"
        nav_links << "<a href=\"#{new_user_session_path}\" class=\"#{tag_classes}\">Log In</a>"
      else
        nav_links << "<a href=\"#{destroy_user_session_path}\" data-method=\"delete\" class=\"#{tag_classes}\">Log Out</a>"
      end
    else
      # Normal navigation links
      nav_items.each do |item|
        nav_links << "<#{parent_tag}><a href=\"#{item[:url]}\" class=\"#{tag_classes} #{active?(item[:url])}\">#{item[:title]}</a></#{parent_tag}>"
      end

      # Devise links
      if current_user.is_a?(GuestUser)
        nav_links << "<#{parent_tag}><a href=\"#{new_user_registration_path}\" class=\"#{tag_classes}\">Sign Up</a></#{parent_tag}>"
        nav_links << "<#{parent_tag}><a href=\"#{new_user_session_path}\" class=\"#{tag_classes}\">Log In</a></#{parent_tag}>"
      else
        nav_links << "<#{parent_tag}><a href=\"#{destroy_user_session_path}\" data-method=\"delete\" class=\"#{tag_classes}\">Log Out</a></#{parent_tag}>"
      end
    end

    nav_links.html_safe
  end

  def active?(path)
    "active" if current_page?(path)
  end

  def alerts
    alert = flash[:alert] || flash[:error] || flash[:notice]
    if alert
      alert_helper(alert)
    end
  end

  def alert_helper(message)
    js add_gritter(message, title: "Marcus Germano, IV Portfolio", sticky: false)
  end
end
