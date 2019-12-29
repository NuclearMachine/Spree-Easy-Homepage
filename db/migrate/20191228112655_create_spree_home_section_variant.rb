class CreateSpreeHomeSectionVariant < SpreeExtension::Migration[4.2]
  def change
    create_table :spree_home_section_variants do |t|
      t.references :variant, index: true
      t.references :home_section, index: true
      t.integer :position, index: true

      t.timestamps
    end
  end
end
