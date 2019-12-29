require 'spec_helper'

describe Spree::HomeSectionVariant do
  describe 'associations' do
    it { is_expected.to belong_to(:home_section).required }
    it { is_expected.to belong_to(:variant).required }
  end

  describe 'after create' do
    let!(:section_variant) { build(:section_variant) }

    it 'should act as a list' do
      expect(section_variant).to respond_to(:set_list_position)
    end
  end
end