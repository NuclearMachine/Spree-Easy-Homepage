(function ($) {
  const addProductSection = function(product, lineItemTemplate) {
   $("#section-product-list").append(lineItemTemplate({product: product}));
  };

  const fillSectionsList = function(lineItemTemplate) {
    const products = $("#section-product-list").data("home-sections");
    $.each(products, function() {
      addProductSection(this, lineItemTemplate);
    });
  };

  const ready = function() {
    const productSearchResult = $("#product-search-result");
    if (productSearchResult.length === 0) return;

    const productResultTemplate = Handlebars.compile(productSearchResult.text());
    const lineItemTemplate = Handlebars.compile($("#product-search-lineitem").text());

    fillSectionsList(lineItemTemplate);

    $(".product-autosearch").productAutoSearch(function(product) {
      const masterImage = product.master.images[0];
      if (masterImage !== undefined && masterImage.mini_url !== undefined) {
        product.image = masterImage.mini_url;
      }
      return productResultTemplate({
        product: product
      });
    }).on("change", function(e) {
      addProductSection(e.added, lineItemTemplate);
    });

    $('#section-product-list').on("click", ".delete-resource", function(e) {
      $(this).closest("tr").remove();
    });

    $('#section-product-list').sortable({handle: '.handle'});
  };

$(document).ready(ready);
})(jQuery);
