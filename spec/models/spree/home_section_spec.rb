require 'spec_helper'

describe Spree::HomeSection do
  describe 'associations' do
    it { is_expected.to have_many(:home_section_products) }
    it { is_expected.to have_many(:products).through(:home_section_products)}
  end

  describe 'after_create' do
    let!(:section) { build(:section) }

    it 'should act as a list' do
      expect(section).to respond_to(:set_list_position)
    end
  end
end