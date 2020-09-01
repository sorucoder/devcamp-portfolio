class Portfolio < ApplicationRecord
	validates_presence_of :title, :body, :main_image, :thumb_image

	scope :rails_items, -> { where(subtitle: 'Ruby on Rails') }
	scope :angular_items, -> { where(subtitle: 'Angular') }

	after_initialize :set_defaults

	def set_defaults
		self.main_image ||= "https://via.placeholder.com/600x400"
		self.thumb_image ||= "https://via.placeholder.com/350x200"
	end
end
