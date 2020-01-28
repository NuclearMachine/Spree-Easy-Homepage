require 'spec_helper'

describe Spree::HomeSection do
  it_behaves_like 'product_ids_processable'

  describe 'associations' do
    it { is_expected.to have_many(:home_section_products).dependent(:destroy) }
    it { is_expected.to have_many(:products).through(:home_section_products) }
  end

  describe 'attributes' do
    it { is_expected.to have_attributes(product_ids: nil) }
  end

  describe 'after create' do
    let(:section) { build(:section) }

    it 'acts as a list' do
      expect(section).to respond_to(:set_list_position)
    end
  end

  describe 'after save' do
    let(:section) { build(:section) }

    context 'if product_ids is present' do
      let(:product1) { create(:product) }
      let(:product2) { create(:product) }
      let(:product3) { create(:product) }

      before do
        section.product_ids = [product1.id, product2.id, product3.id, product1.id]
        section.save
      end

      it 'sets section products' do
        expect(section.home_section_products.first.product).to eq(product1)
        expect(section.home_section_products.second.product).to eq(product2)
        expect(section.home_section_products.third.product).to eq(product3)
        expect(section.home_section_products.fourth.product).to eq(product1)
      end

      it 'sets section product position' do
        expect(section.home_section_products.first.position).to eq(1)
        expect(section.home_section_products.second.position).to eq(2)
        expect(section.home_section_products.third.position).to eq(3)
        expect(section.home_section_products.fourth.position).to eq(4)
      end
    end
  end

  describe 'public interface' do
    let(:section) { create(:section) }

    context 'when invoking delete_sections' do
      let(:section2) { create(:section) }

      before do
        section.products << create_list(:product, 2)
        section2.products << create_list(:product, 2)
      end

      it 'deletes related sections' do
        expect {
          section.delete_sections
        }.to change(section.products, :count).by(-2)
      end

      it 'does not delete unrelated sections' do
        expect {
          section.delete_sections
        }.to change(section2.products, :count).by(0)
      end
    end

    context 'when invoking product_ids?' do
      it 'checks the presence of product_ids' do
        expect(section.product_ids?).to eq(false)
        section.product_ids = [1, 2, 3]
        expect(section.product_ids?).to eq(true)
      end
    end

    context 'when invoking force_delete?' do
      it 'checks the presence of force_delete' do
        expect(section.force_delete?).to eq(false)
        section.force_delete = "true"
        expect(section.force_delete?).to eq(true)
      end
    end

    context 'when invoking section_products?' do
      it 'checks the presence of section_products' do
        expect(section.section_products?).to eq(false)
        section.products << create(:product)
        expect(section.section_products?).to eq(true)
      end
    end

    context 'when invoking products_by_position' do
      it 'checks the presence of products_by_position' do
        section.products << create_list(:product, 5)
        section.products_by_position.each_with_index do |product, index|
          expect(product.home_section_products.first.position).to eq(index + 1)
        end
      end
    end
  end
end
