module Spree
  module EasyHomepage
    class ProductPresenter
      include Rails.application.routes.url_helpers
      include Spree::Core::Engine.routes.url_helpers

      attr_accessor :product
      attr_reader :main_app

      def initialize(product:, main_app:)
        @product = product
        @main_app = main_app
      end

      def parse
        product_attributes
      end

      protected

      def image_link(image_url)
        return if image_url.nil?

        main_app.url_for(image_url)
      end

      def path
        edit_admin_product_path(product)
      end

      private

      def product_attributes
        parser_attributes = product.presenter_attributes
        parser_attributes[:image] = image_link(parser_attributes[:image])
        parser_attributes.merge(path: path)
      end
    end
  end
end
