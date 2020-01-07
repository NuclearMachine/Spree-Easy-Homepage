module Spree::Admin::BaseControllerDecorator
  Spree::Admin::BaseController.include(Spree::Admin::HomeSectionHelper)

  def self.prepended(base)
    base.helper_method :home_section_products
  end
end

Spree::Admin::BaseController.prepend Spree::Admin::BaseControllerDecorator
