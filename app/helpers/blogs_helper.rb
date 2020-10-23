module BlogsHelper
  def gravatar_helper(user)
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", width: 60
  end

  def comment_importance_helper(user)
    if user.role == :site_admin
      "alert alert-primary"
    end
  end
end
