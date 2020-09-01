class Portfolio < ApplicationRecord
	has_many :technologies
	include Placeholder
	validates_presence_of :title, :body, :main_image, :thumb_image

	scope :rails_items, -> { where(subtitle: 'Ruby on Rails') }
	scope :angular_items, -> { where(subtitle: 'Angular') }

	after_initialize :set_defaults

	def set_defaults
		self.main_image ||= Placeholder.image_generator(width: 600, height: 400)
		self.thumb_image ||= Placeholder.image_generator(width: 350, height: 200)
	end
end
