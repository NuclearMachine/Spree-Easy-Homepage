module Spree
  class ProductParser
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

    def product_image
      return unless product.has_images?
      main_app.url_for(image_link)
    end

    def path
      edit_admin_product_path(product)
    end

    private

    def product_attributes
      {
        id: product.id,
        name: product.name,
        image: product_image,
        path: path
      }
    end

    def image_link
      product.image_url(:mini)
    end
  end
end
