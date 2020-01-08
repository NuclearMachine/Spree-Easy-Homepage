require 'spec_helper'

RSpec.feature 'HomeSection management', :js do
  let!(:admin) { create(:admin_user) }

  before do
    login_as(admin, scope: :spree_user)
    visit spree.admin_home_sections_path
  end

  describe 'configuration sidebar' do
    context 'when triggered' do
      it 'shows a clickable button linking to the HomeSection Index page' do
        visit spree.admin_orders_path
        click_link 'Configuration'
        within('#sidebar-configuration') do
          click_link Spree.t(:home_section_menu_name)
          expect(page).to have_current_path spree.admin_home_sections_path
        end
      end
    end
  end

  describe 'index' do
    context 'when no HomeSections are present' do
      it 'displays an alert' do
        expect(page).to have_content('No Home Sections found')
        expect(page).to have_link Spree.t(:add_one), href: spree.new_admin_home_section_path
      end

      it 'has no table present' do
        expect(page).not_to have_selector 'table.sortable'
      end
    end

    context 'when HomeSections are present' do
      let!(:home_section) { create(:section) }

      before do
        create_list(:section_product, 3)
        visit spree.admin_home_sections_path
      end

      it 'has a table filled with HomeSections' do
        expect(page).to have_selector 'table.sortable'
        expect(page).to have_selector 'tr[data-hook=home_sections_row]', count: 4
        title = I18n.t(:title, scope: 'activerecord.attributes.spree/home_section', count: 1).upcase
        within('thead[data-hook=home_sections_header]') do
          expect(page).to have_selector 'th:nth-child(1)', text: ''
          expect(page).to have_selector 'th:nth-child(2)', text: title
          expect(page).to have_selector 'th:nth-child(3)', text: plural_resource_name(Spree::Product).upcase
          expect(page).to have_selector 'th:nth-child(4)', text: ''
        end

        within_row(1) do
          expect(column_text(2)).to have_content home_section.title
          expect(column_text(3)).to have_content home_section.products.count
        end
      end
    end
  end

  describe 'create' do
    context 'when entering the New page and filling the form' do
      let!(:product1) { create(:product) { |product| product.images.create(attributes_for(:image)) } }
      let!(:products) { create_list(:product, 4) }

      it 'saves with the correct title and sections' do
        click_link Spree.t(:new_home_section)

        expect(page).to have_current_path spree.new_admin_home_section_path
        expect(page).to have_content(Spree.t(:new_home_section))

        title = 'Wasabi Master'
        fill_in 'home_section[title]', with: title

        expect {
          select2 product1.name, from: Spree.t(:name_or_sku), search: true
          products.each do |product|
            select2 product.name, from: Spree.t(:name_or_sku), search: true
          end
          within_row(1) do
            accept_alert { click_icon :delete }
          end
          click_button 'Create'
        }.to change(Spree::HomeSectionProduct, :count)
          .by(4)
          .and change(Spree::HomeSection, :count).by(1)

        home_section = Spree::HomeSection.first
        expect(home_section.title).to eq(title)
        expect(page).to have_text 'successfully created!'
        expect(page).to have_current_path spree.admin_home_sections_path
      end
    end
  end

  describe 'edit' do
    let!(:product1) { create(:product) }
    let!(:product2) { create(:product) { |product| product.images.create(attributes_for(:image)) } }
    let!(:home_section) { create(:section) { |section| section.products.create(attributes_for(:product)) } }

    before do
      visit spree.admin_home_sections_path
      within_row(1) { click_icon :edit }
    end

    context 'when entering the Edit page and filling the form' do
      it 'can update an existing home_section' do
        expect(page).to have_current_path spree.edit_admin_home_section_path(home_section)

        old_title = home_section.title
        new_title = 'Wasabi Master Lover'
        fill_in 'home_section[title]', with: new_title

        expect {
          select2 product1.name, from: Spree.t(:name_or_sku), search: true
          select2 product2.name, from: Spree.t(:name_or_sku), search: true
          click_button 'Update'
          home_section.reload
        }.to change(home_section, :title)
          .from(old_title).to(new_title)
          .and change(home_section.products, :count).by(2)

        expect(page).to have_text 'successfully updated!'
      end

      it 'can delete an existing section_product' do
        expect {
          within_row(1) do
            accept_alert { click_icon :delete }
          end
          click_button 'Update'
        }.to change(home_section.products, :count).by(-1)
        expect(page).to have_text 'successfully updated!'
      end
    end
  end
end

private

def plural_resource_name(resource_class)
  resource_class.model_name.human(count: 2.1)
end
