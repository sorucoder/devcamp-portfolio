class PagesController < ApplicationController
  def home
  	@page_title = "Home | Marcus Germano, IV Portfolio"
  end

  def about
  	@page_title = "About Me | Marcus Germano, IV Portfolio"
    @skills = Skill.all.order("title ASC")
  end

  def contact
  	@page_title = "Contact | Marcus Germano, IV Portfolio"
  end

  def tech_news
  	@page_title = "Tech News | Marcus Germano, IV Portfolio"
    @tweets = SocialTool.twitter_search('#coding')
  end
end
