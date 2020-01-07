module Spree
  class HomeSection < Spree::Base
    include Spree::ProductIdsProcessable
    acts_as_list

    has_many :home_section_products, dependent: :destroy
    has_many :products, through: :home_section_products, source: :product

    after_save :reset_section_products

    attr_accessor :product_ids

    def delete_sections
      home_section_products.delete_all
    end

    def has_product_ids?
      product_ids.present?
    end

    protected

    def reset_section_products
      return unless has_product_ids?
      delete_sections
      add_products(product_ids: product_ids)
    end
  end
end
