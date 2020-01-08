module Spree
  module Admin
    module HomeSectionHelper
      def home_section_products
        return [] unless has_sections?
        parse_products(products: @home_section.products_by_position)
      end

      def has_sections?
        @home_section.respond_to?(:home_section_products)
      end

      def parse_products(products:)
        products.map { |product| product_presenter(product: product).as_json }
      end

      def product_presenter(product:)
        presenter(product).parse
      end

      private

      def presenter(product)
        Spree::ProductPresenter.new(product: product, main_app: main_app)
      end
    end
  end
end
