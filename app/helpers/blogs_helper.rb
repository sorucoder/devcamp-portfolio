module BlogsHelper
  def gravatar_helper(user)
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", width: 60
  end

  def comment_importance_helper(user)
    if user.role == :site_admin
      "alert alert-primary"
    end
  end

  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div
    end

    def block_quote(quote)
      %(<blockquote class="blockquote">#{quote}</blockquote>)
    end
  end

  def markdown(text)
    coderayified = CodeRayify.new(filter_html: true, hard_wrap: true)
    options = {
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      autolink: true,
      strikethrough: true,
      space_after_headers: true,
      superscript: true,
      underline: true,
      highlight: true,
      quote: true,
      footnotes: true
    }
    markdown_to_html = Redcarpet::Markdown::new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end

  def blog_status_color_helper(blog)
    if blog.draft?
      "color: red;"
    else
      "color: blue;"
    end
  end
end
