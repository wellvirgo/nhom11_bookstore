$(document).ready(function () {
  // Add autocomplete container after search input
  const $searchInput = $("#menusearch");
  const $searchForm = $("#search-form");

  // Create autocomplete container if it doesn't exist yet
  if ($(".autocomplete-list").length === 0) {
    $searchForm.append('<div class="autocomplete-list"></div>');
  }

  const $autocompleteList = $(".autocomplete-list");

  // Ensure search form has position relative for proper dropdown positioning
  $searchForm.css("position", "relative");

  // Handle input in search box
  $searchInput.on("input", function () {
    const inputValue = $(this).val();

    // Don't show dropdown if input is empty
    if (inputValue.trim() === "") {
      $autocompleteList.hide();
      return;
    }

    // Make API call to get search results
    $.ajax({
      url: `http://localhost:6969/api/search-products?keys=${inputValue}`,
      method: "GET",
      success: function (response) {
        $autocompleteList.empty();

        // Process response data
        if (response.data && response.data.length > 0) {
          // Display each result
          response.data.forEach(function (item) {
            // Extract product info (adjust these based on your API response structure)
            const title = item.name || item.title || item;
            const price = item.price
              ? `${item.price.toLocaleString("vi-VN")}đ`
              : "";
            const image = item.image || "";

            let itemHtml = `
            <div class="autocomplete-item" data-id="${
              item.id
            }" data-title="${title}">
              ${
                image
                  ? `<img src="${image}" alt="${title}" width="30" height="40">`
                  : ""
              }
              <div class="item-details">
                <div class="item-title">${title}</div>
                ${price ? `<div class="item-price">${price}</div>` : ""}
              </div>
            </div>
            `;

            const $item = $(itemHtml);

            // Handle click on autocomplete item
            $item.on("click", function () {
              // Extract just the text title for the search input
              $searchInput.val(title);
              $autocompleteList.hide();
              // Navigate to product detail page
              window.location.href = `detail-product.html?id=${item.id}`;
            });

            $autocompleteList.append($item);
          });

          $autocompleteList.show();
        } else {
          // No results found
          $autocompleteList.html(
            '<div class="autocomplete-empty">No results found</div>'
          );
          $autocompleteList.show();
        }
      },
      error: function (error) {
        console.error("Search API error:", error);
        $autocompleteList.html(
          '<div class="autocomplete-empty">Error searching</div>'
        );
        $autocompleteList.show();
      },
    });
  });

  // Hide results when clicking outside
  $(document).on("click", function (event) {
    if (!$(event.target).closest("#search-form").length) {
      $autocompleteList.hide();
    }
  });

  // Add keyboard navigation support
  $searchInput.on("keydown", function (e) {
    const $items = $autocompleteList.find(".autocomplete-item");

    if ($items.length === 0) return;

    const $highlighted = $autocompleteList.find(
      ".autocomplete-item.highlighted"
    );

    // Down arrow
    if (e.keyCode === 40) {
      e.preventDefault();

      if ($highlighted.length === 0) {
        // No item is highlighted, select the first one
        $items.first().addClass("highlighted");
      } else {
        // Get the next item
        const $next = $highlighted.next(".autocomplete-item");

        $highlighted.removeClass("highlighted");

        // If there's a next item, highlight it, otherwise go back to the first item
        if ($next.length > 0) {
          $next.addClass("highlighted");
        } else {
          $items.first().addClass("highlighted");
        }
      }
    }

    // Up arrow
    else if (e.keyCode === 38) {
      e.preventDefault();

      if ($highlighted.length === 0) {
        // No item is highlighted, select the last one
        $items.last().addClass("highlighted");
      } else {
        // Get the previous item
        const $prev = $highlighted.prev(".autocomplete-item");

        $highlighted.removeClass("highlighted");

        // If there's a previous item, highlight it, otherwise go to the last item
        if ($prev.length > 0) {
          $prev.addClass("highlighted");
        } else {
          $items.last().addClass("highlighted");
        }
      }
    }

    // Enter key
    else if (e.keyCode === 13 && $highlighted.length > 0) {
      e.preventDefault();
      // Navigate to the product detail page
      const id = $highlighted.data("id");
      const title = $highlighted.data("title");

      $searchInput.val(title);
      $autocompleteList.hide();

      window.location.href = `detail-product.html?id=${id}`;
    }
  });
});
