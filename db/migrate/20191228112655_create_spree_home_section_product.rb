class CreateSpreeHomeSectionProduct < SpreeExtension::Migration[4.2]
  def change
    create_table :spree_home_section_products do |t|
      t.references :product, index: true
      t.references :home_section, index: true
      t.integer :position, index: true

      t.timestamps
    end
  end
end
