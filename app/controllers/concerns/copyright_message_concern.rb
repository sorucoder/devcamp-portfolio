module CopyrightMessageConcern
	extend ActiveSupport::Concern

	included do
		before_action :set_copyright_message
	end

	def set_copyright_message
    @copyright = SorucoderViewTool::Renderer.copyright('Marcus "SoruCoder" Germano, IV', 'All rights reserved.')
  end
end