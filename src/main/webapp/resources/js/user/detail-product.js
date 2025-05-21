var thumbsSwiper = new Swiper(".thumbs-slider", {
  direction: "horizontal",
  slidesPerView: 4,
  spaceBetween: 10,
  watchSlidesProgress: true,
  breakpoints: {
    1024: {
      direction: "vertical", // Hiển thị theo hàng ngang trên màn hình >= 768px
      slidesPerView: 4, // Hiển thị 4 slide
    },
  },
});

var mainSwiper = new Swiper(".main-slider", {
  slidesPerView: 1,
  spaceBetween: 10,
  pagination: true,
  thumbs: {
    swiper: thumbsSwiper,
  },
  pagination: {
    el: ".swiper-pagination",
    clickable: true, // Cho phép nhấn vào điểm tròn để chuyển slide
  },
});

// Thêm Swiper cho phần sản phẩm liên quan
var relatedSwiper = new Swiper(".products-carousel", {
  slidesPerView: 4,
  spaceBetween: 30,
  navigation: {
    nextEl: ".products-carousel-next",
    prevEl: ".products-carousel-prev",
  },
  breakpoints: {
    320: {
      slidesPerView: 1,
      spaceBetween: 20,
    },
    480: {
      slidesPerView: 2,
      spaceBetween: 20,
    },
    768: {
      slidesPerView: 3,
      spaceBetween: 30,
    },
    1024: {
      slidesPerView: 4,
      spaceBetween: 30,
    },
  },
});

document.addEventListener("DOMContentLoaded", function () {
  // Lấy tham số từ URL
  const params = new URLSearchParams(window.location.search);
  const category = params.get("id");
  getDetailProduct(category);
  getRelatedProduct();
});
async function getDetailProduct(params) {
  try {
    const response = await fetch(
      `http://localhost:6969/api/get-product-details?id=` + params
    );
    const data = await response.json();
    fetchData(data.product);
  } catch (error) {
    console.log("Đã có lỗi xảy ra", error);
  }
}
async function getRelatedProduct() {
  try {
    const response = await fetch(
      `http://localhost:6969/api/get-products?limit=8`
    );
    const data = await response.json();
    fetchRelatedProduct(data.products);
  } catch (error) {
    console.log("Đã có lỗi xảy ra", error);
  }
}
function fetchRelatedProduct(items) {
  const container = document.getElementById("swiper-wrapper-27c5ac6294c32634");
  container.innerHTML = "";
  items.forEach((item, index) => {
    console.log(index);
    const html = `<div class="swiper-slide swiper-slide-active" role="group" aria-label='${
      index + 1
    } / 8' style="width: 233.667px; margin-right: 30px;">
              <div class="product-item " >
                <span class="badge bg-success position-absolute m-3">-30%</span>
                <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                <figure>
                  <a href="detail-product.html?id=${
                    item.id
                  }" title="Product Title">
                    <img src="${item.image}" alt="${
      item.name
    }" class="tab-image">
                  </a>
                </figure>
                <h3 style="min-height: 50px;" class="item-name">${
                  item.name
                }</h3>
                <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                <span class="price">${item.price.toLocaleString()}đ</span>
                <div class="d-flex align-items-center ">
                  <div class="input-group product-qty">
                      <span class="input-group-btn">
                          <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus" onclick="minusQuantity(${
                            item.id
                          })">
                            <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                          </button>
                      </span>
                      <input type="text" id="quantity-${
                        item.id
                      }" name="quantity" class="form-control input-number" value="1">
                      <span class="input-group-btn">
                          <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus" onclick="plusQuantity(${
                            item.id
                          })">
                              <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                          </button>
                      </span>
                  </div>
                  <a href="#" class="nav-link" onclick="addToCart(1, ${
                    item.id
                  }, document.getElementById('quantity-${
      item.id
    }').value)">Add to Cart <iconify-icon icon="uil:shopping-cart"></a>
                </div>
              </div>
            </div>`;
    container.innerHTML += html;
  });
}
function fetchData(item) {
  const container1 = document.getElementById("img-swiper");
  const container2 = document.getElementById("img-swiper-2");
  item.images.forEach((a) => {
    imageHtml = `<div class="swiper-slide"><img src=${a.url}  alt="Image 1"></div>`;
    container1.insertAdjacentHTML("beforeend", imageHtml);
    container2.insertAdjacentHTML("beforeend", imageHtml);
    thumbsSwiper.update();
    mainSwiper.update();
  });
  const container = document.getElementById("detail-product");
  const descriptionContainer = document.getElementById("description-product");
  const splitIndex = Math.floor(item.description.length / 2); // Cắt một nửa
  const firstHalf = item.description.slice(0, splitIndex);
  const secondHalf = item.description.slice(splitIndex);
  container.innerHTML = ` <div class="product-info">
                <div class="element-header">
                    <h2 itemprop="name" class="display-6">${item.name}</h2>
                </div>
                <div class="product-price pt-3 pb-3">
                  <strong class="text-primary display-6 fw-bold">${item.price.toLocaleString()}đ</strong>
                  <del class="ms-2">${item.originalPrice.toLocaleString()}đ</del>
                </div>
                <div class="cart-wrap py-5">
                  <div class="color-options product-select">
                    <div class="color-toggle">
                      <h6 class="item-title text-uppercase text-dark">Phân loại</h6>
                      <ul class="select-list list-unstyled d-flex">
                        <li value="Green" class="select-item pe-3"><a href="#" class="btn btn-light active">Bìa mềm</a></li>
                        <li value="Green" class="select-item pe-3"><a href="#" class="btn btn-light ">Bìa cứng</a></li>
                      </ul>
                    </div>
                  </div>
                  <div class="product-quantity pt-3">
                    <div class="stock-number text-dark">
                      <em>Còn ${item.quantityAvailable} sản phẩm</em>
                    </div>
                    <div class="stock-button-wrap">
                      <div class="input-group product-qty" style="max-width: 150px;">
                        <span class="input-group-btn">
                          <button class="quantity-left-minus btn btn-light btn-number" onclick="minusQuantity(${
                            item.id
                          })">-</button>
                        </span>
                        <input id="quantity-${
                          item.id
                        }" name="quantity" class="form-control input-number text-center" value="1" max="100" min="1">
                        <span class="input-group-btn">
                          <button class="quantity-left-minus btn btn-light btn-number" onclick="plusQuantity(${
                            item.id
                          })">+</button>
                        </span>
                      </div>
                    </div>
                  </div>
                  <div class="qty-button d-flex flex-wrap pt-3">
                    <button type="submit" class="btn btn-primary py-3 px-4 text-uppercase me-3 mt-3">Mua ngay</button>
                    <button type="submit" class="btn btn-dark py-3 px-4 text-uppercase mt-3" onclick="addToCart(1, ${
                      item.id
                    }, document.getElementById('quantity-${
    item.id
  }').value)">Thêm vào giỏ hàng</button>
                  </div>
                </div>
        </div> `;
  descriptionContainer.innerHTML = `<section class="product-info-tabs py-5">
      <div class="container-fluid">
        <div class="row">
          <div class="d-flex flex-column flex-md-row align-items-start gap-5">
            <div class="nav flex-row flex-wrap flex-md-column nav-pills me-3 col-lg-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
              <button class="nav-link text-start active" id="v-pills-description-tab" data-bs-toggle="pill" data-bs-target="#v-pills-description" type="button" role="tab" aria-controls="v-pills-description" aria-selected="true">Description</button>
              <button class="nav-link text-start" id="v-pills-additional-tab" data-bs-toggle="pill" data-bs-target="#v-pills-additional" type="button" role="tab" aria-controls="v-pills-additional" aria-selected="false" tabindex="-1">Additional Information</button>
              <button class="nav-link text-start" id="v-pills-reviews-tab" data-bs-toggle="pill" data-bs-target="#v-pills-reviews" type="button" role="tab" aria-controls="v-pills-reviews" aria-selected="false" tabindex="-1">Customer Reviews</button>
            </div>
            <div class="tab-content" id="v-pills-tabContent">
              <div class="tab-pane fade active show" id="v-pills-description" role="tabpanel" aria-labelledby="v-pills-description-tab" tabindex="0">
                <h5>Mô tả sản phẩm</h5>
                               <div x-data="{ isExpanded: false }">
                <p x-show="isExpanded" x-collapse.min.200px>
                  ${item.description}
                </p>
                <button class="btn btn-link p-0" @click="isExpanded = !isExpanded">
                  <span x-text="isExpanded ? 'Ẩn bớt' : 'Xem thêm'"></span>
                </button>
                </div>
              </div>
              <div class="tab-pane fade" id="v-pills-additional" role="tabpanel" aria-labelledby="v-pills-additional-tab" tabindex="0">
                <h5>Thông tin chi tiết</h5>
                <div class="meta-product py-2">
                  <div class="meta-item d-flex align-items-baseline">
                    <h6 class="item-title no-margin pe-2">Mã hàng:</h6>
                    <ul class="select-list list-unstyled d-flex">
                      <li class="select-item">${item.productCode}</li>
                    </ul>
                  </div>
                  <div class="meta-item d-flex align-items-baseline">
                    <h6 class="item-title no-margin pe-2">Tên nhà cung cấp:</h6>
                    <ul class="select-list list-unstyled d-flex">
                      <li class="select-item"><a href="#">${item.supplier}</a></li>
                    </ul>
                  </div>
                  <div class="meta-item d-flex align-items-baseline">
                    <h6 class="item-title no-margin pe-2">Tác giả:</h6>
                    <ul class="select-list list-unstyled d-flex">
                      <li class="select-item">${item.author}</li>
                    </ul>
                  </div>
                  <div class="meta-item d-flex align-items-baseline">
                    <h6 class="item-title no-margin pe-2">Ngôn ngữ:</h6>
                    <ul class="select-list list-unstyled d-flex">
                      <li class="select-item">${item.language}</li>
                    </ul>
                  </div>
                  <div class="meta-item d-flex align-items-baseline">
                    <h6 class="item-title no-margin pe-2">NXB:</h6>
                    <ul class="select-list list-unstyled d-flex">
                      <li class="select-item">${item.publisher}</li>
                    </ul>
                  </div>
                  <div class="meta-item d-flex align-items-baseline">
                    <h6 class="item-title no-margin pe-2">Năm XB:</h6>
                    <ul class="select-list list-unstyled d-flex">
                      <li class="select-item">${item.publishYear}</li>
                    </ul>
                  </div>
                  <div class="meta-item d-flex align-items-baseline">
                    <h6 class="item-title no-margin pe-2">Trọng lượng:</h6>
                    <ul class="select-list list-unstyled d-flex">
                      <li class="select-item">${item.weight}g</li>
                    </ul>
                  </div>
                  <div class="meta-item d-flex align-items-baseline">
                    <h6 class="item-title no-margin pe-2">Số trang:</h6>
                    <ul class="select-list list-unstyled d-flex">
                      <li class="select-item">${item.quantityOfPages} tờ</li>
                    </ul>
                  </div>
                </div> 
              </div>
              <div class="tab-pane fade" id="v-pills-reviews" role="tabpanel" aria-labelledby="v-pills-reviews-tab" tabindex="0">
                <div class="review-box d-flex flex-wrap">
                  <div class="col-lg-6 d-flex flex-wrap gap-3">
                    <div class="col-md-2">
                      <div class="image-holder">
                        <img src="images/reviewer-1.jpg" alt="review" class="img-fluid rounded-circle">
                      </div>
                    </div>
                    <div class="col-md-8">
                      <div class="review-content">
                        <div class="rating-container d-flex align-items-center">
                          <div class="rating" data-rating="1">
                            <svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <div class="rating" data-rating="2">
                            <svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <div class="rating" data-rating="3">
                            <svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <div class="rating" data-rating="4">
                            <svg width="24" height="24" class="text-secondary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <div class="rating" data-rating="5">
                            <svg width="24" height="24" class="text-secondary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <span class="rating-count">(3.5)</span>
                        </div>
                        <div class="review-header">
                          <span class="author-name">Tina Johnson</span>
                          <span class="review-date">– 03/07/2023</span>
                        </div>
                        <p>Vitae tortor condimentum lacinia quis vel eros donec ac. Nam at lectus urna duis convallis convallis</p>
                      </div>
                    </div>
                  </div>
                  <div class="col-lg-6 d-flex flex-wrap gap-3">
                    <div class="col-md-2">
                      <div class="image-holder">
                        <img src="images/reviewer-2.jpg" alt="review" class="img-fluid rounded-circle">
                      </div>
                    </div>
                    <div class="col-md-8">
                      <div class="review-content">
                        <div class="rating-container d-flex align-items-center">
                          <div class="rating" data-rating="1">
                            <svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <div class="rating" data-rating="2">
                            <svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <div class="rating" data-rating="3">
                            <svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <div class="rating" data-rating="4">
                            <svg width="24" height="24" class="text-secondary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <div class="rating" data-rating="5">
                            <svg width="24" height="24" class="text-secondary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <span class="rating-count">(3.5)</span>
                        </div>
                        <div class="review-header">
                          <span class="author-name">Jenny Willis</span>
                          <span class="review-date">– 03/06/2022</span>
                        </div>
                        <p>Vitae tortor condimentum lacinia quis vel eros donec ac. Nam at lectus urna duis convallis convallis</p>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="add-review mt-5">
                  <h3>Add a review</h3>
                  <p>Your email address will not be published. Required fields are marked *</p>
                  <form id="form" class="form-group">

                    <div class="pb-3">
                      <div class="review-rating">
                        <span>Your rating *</span>
                        <div class="rating-container d-flex align-items-center">
                          <div class="rating" data-rating="1">
                            <svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <div class="rating" data-rating="2">
                            <svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <div class="rating" data-rating="3">
                            <svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <div class="rating" data-rating="4">
                            <svg width="24" height="24" class="text-secondary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <div class="rating" data-rating="5">
                            <svg width="24" height="24" class="text-secondary"><use xlink:href="#star-solid"></use></svg>
                          </div>
                          <span class="rating-count">(3.5)</span>
                        </div>
                      </div>
                    </div>
                    <div class="pb-3">
                      <input type="file" class="form-control" data-text="Choose your file">
                    </div>
                    <div class="pb-3">
                      <label>Your Review *</label>
                      <textarea class="form-control" placeholder="Write your review here"></textarea>
                    </div>
                    <div class="pb-3">
                      <label>Your Name *</label>
                      <input type="text" name="name" placeholder="Write your name here" class="form-control">
                    </div>
                    <div class="pb-3">
                      <label>Your Email *</label>
                      <input type="text" name="email" placeholder="Write your email here" class="form-control">
                    </div>
                    <div class="pb-3">
                      <label>
                        <input type="checkbox" required="">
                        <span class="label-body">Save my name, email, and website in this browser for the next
                          time.</span>
                      </label>
                    </div>
                    <button type="submit" name="submit" class="btn btn-dark btn-large text-uppercase w-100">Submit</button>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>        `;
}
