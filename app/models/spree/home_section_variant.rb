module Spree
  class HomeSectionVariant < Spree::Base
    acts_as_list

    belongs_to :home_section, class_name: 'Spree::HomeSection', required: true
    belongs_to :variant, class_name: 'Spree::Variant', required: true
  end
end