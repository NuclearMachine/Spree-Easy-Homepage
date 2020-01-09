module Spree
  module EasyHomepageHelper
    def fill_with_sections(partial: home_section_partial, **partial_args)
      render(partial: partial, **partial_args)
    end

    def home_sections
      Spree::HomeSection.all
    end

    private

    def home_section_partial
      'spree/shared/home_sections'
    end
  end
end
