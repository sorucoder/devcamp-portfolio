class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include DeviseWhitelistConcern
  include SetSourceConcern
  include CurrentUserConcern
  include DefaultPageContent
  include SidebarTopicsConcern
  include CopyrightMessageConcern
  include VotableToggleConcern
end