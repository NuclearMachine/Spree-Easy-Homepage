module Spree
  class HomeSection < Spree::Base
    include Spree::ProductIdsProcessable
    acts_as_list

    has_many :home_section_products, dependent: :destroy
    has_many :products, through: :home_section_products, source: :product

    alias_attribute :sections, :home_section_products

    after_save :reset_section_products

    attr_accessor :product_ids, :force_delete

    def delete_sections
      home_section_products.delete_all
    end

    def product_ids?
      product_ids.present?
    end

    def force_delete?
      force_delete.present?
    end

    def products_by_position
      products.order('spree_home_section_products.position ASC')
    end

    def section_products?
      home_section_products.any?
    end

    protected

    def reset_section_products
      delete_sections if force_delete?
      return unless product_ids?

      add_products(product_ids: product_ids)
    end
  end
end
