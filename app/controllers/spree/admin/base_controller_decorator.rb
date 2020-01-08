module Spree
  module Admin
    module BaseControllerDecorator
      Spree::Admin::BaseController.include(Spree::Admin::HomeSectionHelper)

      def self.prepended(base)
        base.helper_method :parse_home_sections
      end
    end
  end
end

Spree::Admin::BaseController.prepend Spree::Admin::BaseControllerDecorator
