module PortfoliosHelper
  def placeholder_image_generator(width:, height:)
    return "http://placehold.it/#{width}x#{height}"
  end

  def portfolio_image_helper(image, type)
    if not image.url.nil?
      image.url.to_s
    elsif type == :main
      placeholder_image_generator(width: 600, height: 400)
    elsif type == :thumb
      placeholder_image_generator(width: 350, height: 200)
    end
  end
end
