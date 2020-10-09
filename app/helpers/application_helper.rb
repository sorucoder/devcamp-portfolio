module ApplicationHelper
  def login_helper(style)
    if current_user.is_a?(GuestUser)
      (link_to 'Sign Up', new_user_registration_path, class: style) +
      (link_to 'Login', new_user_session_path, class: style)
    else
      link_to 'Logout', destroy_user_session_path, method: :delete, class: style
    end
  end

  def source_helper(layout_name)
    if session[:source]
      greeting = "Thanks for visiting me from #{session[:source]} and you are #{layout_name} layout"
      content_tag(:p, greeting, class: 'source-greeting')
    end
  end

  def copyright_helper
    SorucoderViewTool::Renderer.copyright('Marcus "SoruCoder" Germano, IV', 'All rights reserved.')
  end
end
