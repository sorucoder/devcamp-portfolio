module PortfoliosHelper
  def placeholder_image_generator(width:, height:)
    return "http://placehold.it/#{width}x#{height}"
  end

  def portfolio_image_helper(image, type)
    if image.model.main_image? || image.model.thumb_image?
      image
    elsif type == :thumb
      placeholder_image_generator(width: 350, height: 200)
    else
      placeholder_image_generator(width: 600, height: 400)
    end
  end
end
