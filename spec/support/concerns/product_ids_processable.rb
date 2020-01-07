require 'spec_helper'

shared_examples_for 'product_ids_processable' do
  describe 'public interface' do
    let!(:model) { create(described_class.to_s.underscore) }

    context 'when add_product is invoked' do
      it 'adds a product' do
        expect {
          model.add_product(product_id: create(:product).id)
        }.to change(model.products, :count).by(1)
      end
    end

    context 'when add_products is invoked' do
      it 'adds products based on product_ids' do
        product_ids = create_list(:product, 4).to_a.map(&:id)
        expect {
          model.add_products(product_ids: product_ids)
        }.to change(model.products, :count).by(4)
      end
    end
  end
end
