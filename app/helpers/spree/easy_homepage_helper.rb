module Spree
  module EasyHomepageHelper
    def fill_with_sections(partial: home_section_partial, **partial_args)
      get_homesection_partial(partial: partial, **partial_args)
    end

    def home_sections
      Spree::HomeSection.all
    end

    private

    def get_homesection_partial(partial: home_section_partial, **partial_args)
      render(partial: partial, **partial_args)
    end

    def home_section_partial
      'spree/shared/home_sections'
    end
  end
end

# Author note:
# This helper and the homesection partial view, violates a few OOP principles
# I plan to change this when I have time to do so.
# Although I don't plan to change the public interface,
# the private interface will.
# for example, instead of calling render,
# a new Presenter or Service object would instead be called
