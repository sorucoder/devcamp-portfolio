module ApplicationHelper
  def source_helper(layout_name)
    if session[:source]
      greeting = "Thanks for visiting me from #{session[:source]} and you are #{layout_name} layout"
      content_tag(:p, greeting, class: 'source-greeting')
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

  def nav_helper(styleClass, parentTag: nil)
    nav_links = ''
    
    if parentTag.nil?
      # Normal navigation links
      nav_items.each do |item|
        nav_links << "<a href=\"#{item[:url]}\" class=\"#{styleClass} #{active?(item[:url])}\">#{item[:title]}</a>"
      end

      # Devise links
      if current_user.is_a?(GuestUser)
        nav_links << "<a href=\"#{new_user_registration_path}\" class=\"#{styleClass}\">Sign Up</a>"
        nav_links << "<a href=\"#{new_user_session_path}\" class=\"#{styleClass}\">Log In</a>"
      else
        nav_links << "<a href=\"#{destroy_user_session_path}\" data-method=\"delete\" class=\"#{styleClass}\">Log Out</a>"
      end
    else
      # Normal navigation links
      nav_items.each do |item|
        nav_links << "<#{parentTag}><a href=\"#{item[:url]}\" class=\"#{styleClass} #{active?(item[:url])}\">#{item[:title]}</a></#{parentTag}>"
      end

      # Devise links
      if current_user.is_a?(GuestUser)
        nav_links << "<#{parentTag}><a href=\"#{new_user_registration_path}\" class=\"#{styleClass}\">Sign Up</a></#{parentTag}>"
        nav_links << "<#{parentTag}><a href=\"#{new_user_session_path}\" class=\"#{styleClass}\">Log In</a></#{parentTag}>"
      else
        nav_links << "<#{parentTag}><a href=\"#{destroy_user_session_path}\" data-method=\"delete\" class=\"#{styleClass}\">Log Out</a></#{parentTag}>"
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
