module Spree
  module ProductIdsProcessable
    extend ActiveSupport::Concern

    def add_product(product_id:)
      products << Spree::Product.find(product_id)
    end

    def add_products(product_ids:)
      clean_ids(product_ids).each { |id| add_product(product_id: id) }
    end

    protected

    def clean_ids(ids)
      ids.reject(&:blank?)
    end
  end
end
