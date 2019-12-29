module Spree
  class HomeSection < Spree::Base
    acts_as_list

    has_many :home_section_variants, dependent: :destroy
    has_many :variants, through: :home_section_variants, source: :variant
  end
end