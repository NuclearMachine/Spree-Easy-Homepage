FactoryBot.define do
  factory :section_variant, class: Spree::HomeSectionVariant do
    variant
    association :home_section, factory: :section
  end
end