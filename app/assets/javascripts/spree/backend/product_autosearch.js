(function ($) {
  $.fn.productAutoSearch = function(formatResult) {
    return this.select2({
      placeholder: Spree.translations.product_placeholder,
      minimumInputLength: 3,
      ajax: {
        url: Spree.routes.products_api,
        quietMillis: 200,
        datatype: 'json',
        cache: true,
        data: function(term) {
          return {
            q: {
              name_or_master_sku_cont: term
            },
            token: Spree.api_key,
            per_page: 5
          };
        },
        results: function(data) {
          var products = data.products ? data.products : [];
          return {
            results: data.products
          };
        }
      },
      formatResult: formatResult,
      formatSelection: function(product) {
        return Select2.util.escapeMarkup(product.name);
      }
    });
  };
})(jQuery);
