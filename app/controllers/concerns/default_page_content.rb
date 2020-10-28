module DefaultPageContent
  extend ActiveSupport::Concern

  included do
    before_action :set_page_defaults
  end

  def set_page_defaults
    @seo_keywords = 'Marcus Germano portfolio blogs'
    @page_title = "Marcus Germano, IV Portfolio"
  end
end