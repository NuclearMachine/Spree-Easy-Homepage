module Spree::VariantDecorator
  def self.prepended(base)
    base.has_many :home_section_variants, class_name: 'Spree::HomeSectionVariant'
    base.has_many :home_sections, through: :home_section_variants, class_name: 'Spree::HomeSection'
  end
end

Spree::Variant.prepend Spree::VariantDecorator
