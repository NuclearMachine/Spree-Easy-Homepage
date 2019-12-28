class CreateSpreeHomeSection < SpreeExtension::Migration[4.2]
  def change
    create_table :spree_home_sections do |t|
      t.string :title
      t.integer :position, index: true

      t.timestamps
    end
  end
end
