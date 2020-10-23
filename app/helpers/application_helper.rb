module ApplicationHelper
  def get_record()
    model = controller_name.classify.constantize
    model.find(params[:id])
  end

  def page_title_items
    {
      %r{^devise/[a-z_]+$} => [
        {
          url: new_user_registration_path,
          title: "Sign Up"
        },
        {
          url: new_user_session_path,
          title: "Log In"
        },
        {
          url: new_user_password_path,
          title: "Forgot Your Password?"
        },
        {
          url: edit_user_password_path,
          title: "Recover Your Password?"
        },
      ],
      portfolios: [
        {
          url: portfolios_path,
          title: "My Portfolio"
        },
        {
          url: new_portfolio_path,
          title: "New Portfolio Item"
        },
        {
          url: -> (id) { edit_portfolio_path(id) },
          title: -> { "Edit Portfolio Item \"#{@portfolio_item.title}\"" }
        },
        {
          url: -> (id) { portfolio_show_path(id) },
          title: -> { @portfolio_item.title }
        }
      ],
      pages: [
        {
          url: about_me_path,
          title: "About Me"
        },
        {
          url: contact_path,
          title: "Contact" 
        },
        {
          url: tech_news_path,
          title: "Tech News"
        },
        {
          url: root_path,
          title: "Home"
        }
      ],
      blogs: [
        {
          url: blogs_path,
          title: "SoruCoder's Blog"
        },
        {
          url: new_blog_path,
          title: "New Blog Post"
        },
        {
          url: -> (id) { edit_blog_path(id) },
          title: -> { "Edit Blog \"#{@blog.title}\"" }
        },
        {
          url: -> (id) { blogs_path(id) },
          title: -> { @blog.title }
        },

      ]
    }
  end

  def page_title_helper
    page_title_items.each do |controller, pages|
      # Determine if the current page by controller. This is to avoid, for example,
      # getting the title for the home page, but check if we are viewing a portfolio
      # item (in which the home page doesn't have an id parameter, in which would cause
      # the entire helper to fail). This also avoids giving a portfolios title when
      # viewing a blog, where ids may overlap. Anyhow, if the controller doesn't match,
      # skip to the next controller collection.
      if controller.is_a?(Regexp)
        next unless controller =~ controller_name
      else
        next unless controller.to_s == controller_name
      end

      # Now we can check each page, and map it to its correct title.
      pages.each do |page|
        url = page[:url]
        if page[:url].is_a?(Proc)
          url = url.call(params[:id])
        end

        if current_page?(url)
          if page[:title].is_a?(Proc)
            return "#{page[:title].call()} | Marcus Germano, IV"
          else
            return "#{page[:title]} | Marcus Germano, IV"
          end
        end
      end
    end
    "Marcus Germano, IV"
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
