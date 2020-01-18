module Spree
  module Admin
    module HomeSectionHelper
      def parse_home_sections(home_section)
        return [] unless home_section.section_products?

        parse_products(products: home_section.products_by_position)
      end

      def parse_products(products:)
        products.map { |product| product_presenter(product: product).as_json }
      end

      def product_presenter(product:)
        presenter(product).parse
      end

      private

      def presenter(product)
        Spree::EasyHomepage::ProductPresenter.new(
          product: product,
          main_app: main_app
        )
      end
    end
  end
end
