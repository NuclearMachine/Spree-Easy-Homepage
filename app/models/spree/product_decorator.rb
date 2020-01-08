module Spree
  module ProductDecorator
    def self.prepended(base)
      base.has_many :home_section_products,
                    class_name: 'Spree::HomeSectionProduct'

      base.has_many :home_sections,
                    through: :home_section_products,
                    class_name: 'Spree::HomeSection'
    end

    def image_url(style: :product)
      image = images.first
      return if image.blank?

      image.url(style)
    end

    def presenter_attributes
      {
        id: id,
        name: name,
        image: image_url(style: :mini)
      }
    end
  end
end

Spree::Product.prepend Spree::ProductDecorator
