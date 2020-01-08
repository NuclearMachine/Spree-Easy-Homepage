Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_configuration',
  name: 'home_section_menu_item',
  insert_after: "erb[loud]:contains('configurations_sidebar_menu_item(Spree.t(:general_settings), spree.edit_admin_general_settings_path) if can? :manage, Spree::Config')",
  text: "<%= configurations_sidebar_menu_item(
                Spree.t(:home_section_menu_name),
                spree.admin_home_sections_path) if can? :manage, Spree::HomeSection %>"
)
