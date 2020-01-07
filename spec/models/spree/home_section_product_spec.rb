require 'spec_helper'

describe Spree::HomeSectionProduct do
  describe 'associations' do
    it { is_expected.to belong_to(:home_section).required }
    it { is_expected.to belong_to(:product).required }
  end

  describe 'after create' do
    let!(:section_product) { build(:section_product) }

    it 'acts as a list' do
      expect(section_product).to respond_to(:set_list_position)
    end
  end
end
