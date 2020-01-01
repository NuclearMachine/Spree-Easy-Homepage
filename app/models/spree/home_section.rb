module Spree
  class HomeSection < Spree::Base
    acts_as_list

    has_many :home_section_products, dependent: :destroy
    has_many :products, through: :home_section_products, source: :product
  end
end
