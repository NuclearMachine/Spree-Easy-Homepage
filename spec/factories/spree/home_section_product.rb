FactoryBot.define do
  factory :section_product, class: 'Spree::HomeSectionProduct' do
    product
    association :home_section, factory: :section
  end
end
