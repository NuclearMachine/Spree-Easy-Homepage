require 'spec_helper'

describe Spree::EasyHomepage::ProductPresenter do
  let(:product_presenter) { described_class.new(product: product, main_app: spree) }
  let(:product) { create(:product) { |product| product.images.create(attributes_for(:image)) } }

  describe 'public interface' do
    context 'when parse is invoked' do
      it 'parses without raising any errors' do
        expect { product_presenter.parse }.not_to raise_error
      end

      it 'returns the correct hash of product attributes' do
        product_hash = product_presenter.parse
        expect(product_hash[:id]).to eq(product.id)
        expect(product_hash[:name]).to eq(product.name)
        expect(product_hash[:path]).to eq(spree.edit_admin_product_path(product))
        expect(product_hash[:image]).not_to be_empty
      end
    end
  end
end
