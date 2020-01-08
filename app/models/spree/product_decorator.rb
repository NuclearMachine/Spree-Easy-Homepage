module Spree::ProductDecorator
  def self.prepended(base)
    base.has_many :home_section_products, class_name: 'Spree::HomeSectionProduct'
    base.has_many :home_sections, through: :home_section_products, class_name: 'Spree::HomeSection'
  end

  def image_url(style = :product)
    image = images.first
    return unless image.present?
    image.url(style)
  end

  def has_images?
    images.any?
  end
end

Spree::Product.prepend Spree::ProductDecorator
