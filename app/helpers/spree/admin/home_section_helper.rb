module Spree
  module Admin
    module HomeSectionHelper
      def home_section_products
        return [] unless @home_section.respond_to?(:home_section_products)

        @home_section.products.order("spree_home_section_products.position asc").map { |product|
          product.as_json(only: [:id, :name]).merge({
            image: product.master_images.any? &&
              main_app.url_for(product.master_images.first.url(:mini)),
            path: edit_admin_product_path(product)
          })
        }
      end
    end
  end
end
