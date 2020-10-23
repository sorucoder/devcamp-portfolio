class PagesController < ApplicationController
  def home
    @page_title = "Home | Marcus Germano, IV"
  end

  def about
    @page_title = "About Me | Marcus Germano, IV"
  end

  def contact
    @page_title = "Contact | Marcus Germano, IV"
  end

  def tech_news
    @page_title = "Tech News | Marcus Germano, IV"
    @tweets = SocialTool.twitter_search('#coding')
  end
end
