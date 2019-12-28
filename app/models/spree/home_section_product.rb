module Spree
  class HomeSectionProduct < Spree::Base
    acts_as_list

    belongs_to :home_section, class_name: 'Spree::HomeSection'
    belongs_to :product, class_name: 'Spree::Product'
  end
end