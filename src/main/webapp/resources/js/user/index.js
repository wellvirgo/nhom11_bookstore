$(document).ready(function () {
  const $searchInput = $("#menusearch");
  const $searchForm = $("#search-form");

  // Create autocomplete container if it doesn't exist yet
  if ($(".autocomplete-list").length === 0) {
    $searchForm.append('<div class="autocomplete-list"></div>');
  }

  const $autocompleteList = $(".autocomplete-list");
  $searchForm.css("position", "relative");

  // Handle input in search box
  $searchInput.on("input", function () {
    const inputValue = $(this).val();

    if (inputValue.trim() === "") {
      $autocompleteList.hide();
      return;
    }

    // Gọi đúng endpoint trả về JSON cho autocomplete
    $.ajax({
      url: `/user/search-json?keyword=${encodeURIComponent(inputValue)}`,
      method: "GET",
      success: function (response) {
        $autocompleteList.empty();

        // response là mảng ProductforJsonDTO
        if (response && response.length > 0) {
          response.forEach(function (item) {
            const title = item.name;
            const image = item.image || "";

            let itemHtml = `
              <div class="autocomplete-item" data-id="${item.id}" data-title="${title}">
                ${image ? `<img src="${image}" alt="${title}" width="30" height="40">` : ""}
                <div class="item-details">
                  <div class="item-title">${title}</div>
                </div>
              </div>
            `;

            const $item = $(itemHtml);

            // Khi click vào item, chuyển đến trang chi tiết sản phẩm
            $item.on("click", function () {
              window.location.href = `/user/detail/${item.id}`;
            });

            $autocompleteList.append($item);
          });

          $autocompleteList.show();
        } else {
          $autocompleteList.html(
            '<div class="autocomplete-empty">Không tìm thấy sản phẩm</div>'
          );
          $autocompleteList.show();
        }
      },
      error: function (error) {
        console.error("Search API error:", error);
        $autocompleteList.html(
          '<div class="autocomplete-empty">Lỗi khi tìm kiếm</div>'
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
        $items.first().addClass("highlighted");
      } else {
        const $next = $highlighted.next(".autocomplete-item");
        $highlighted.removeClass("highlighted");
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
        $items.last().addClass("highlighted");
      } else {
        const $prev = $highlighted.prev(".autocomplete-item");
        $highlighted.removeClass("highlighted");
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
      const id = $highlighted.data("id");
      const title = $highlighted.data("title");

      $searchInput.val(title);
      $autocompleteList.hide();

      window.location.href = `/user/detail/${id}`;
    }
  });
});