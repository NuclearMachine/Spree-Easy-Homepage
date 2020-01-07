module Spree
  class HomeSectionProduct < Spree::Base
    acts_as_list scope: :home_section

    belongs_to :home_section, class_name: 'Spree::HomeSection', required: true
    belongs_to :product, class_name: 'Spree::Product', required: true
  end
end
