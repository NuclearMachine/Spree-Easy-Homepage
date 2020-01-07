FactoryBot.define do
  factory :section, aliases: ['spree/home_section'], class: 'Spree::HomeSection' do
    title { 'Test Section' }
  end
end
