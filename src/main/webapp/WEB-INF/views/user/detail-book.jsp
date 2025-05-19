<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>FoodMart - Free eCommerce Grocery Store HTML Website Template</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="author" content="">
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/css/user/vendor.css">
    <link rel="stylesheet" type="text/css" href="/css/user/style.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Open+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="/css/user/detail-product.css" rel="stylesheet">
  </head>
  <span>
    <div class="preloader-wrapper">
      <div class="preloader">
      </div>
    </div>
    <jsp:include page="header.jsp" />
  <section id="selling-product" class="single-product mt-0 mt-md-5" >
    <div class="container-fluid">
      <nav class="breadcrumb fs-6">
        <a class="breadcrumb-item nav-link" href="#">Home</a>
        <a class="breadcrumb-item nav-link" href="#">Home</a>
        <span class="breadcrumb-item active" href="#">Checkout</span>
      </nav>
    <div class="row g-5">
        <div class="col-lg-7">
            <div class="row flex-column-reverse flex-lg-row">
                <div class="col-md-12 col-lg-2">
                        <!-- Thumbnail Swiper -->
                        <div class="swiper thumbs-slider">
                            <div class="swiper-wrapper" id="img-swiper">
                                <c:forEach var="image" items="${product.images}">
                                    <div class="swiper-slide">
                                        <img src="${image.url}" alt="Product Thumbnail">
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                </div>
                    <div class="col-md-12 col-lg-10">
                        <!-- Main Swiper -->
                        <div class="swiper main-slider">
                            <div class="swiper-wrapper" id="img-swiper-2">
                                <c:forEach var="image" items="${product.images}">
                                    <div class="swiper-slide">
                                        <img src="${image.url}" alt="Product Image">
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="swiper-pagination"></div>
                        </div>
                    </div>
            </div>
        </div>
        <div class="col-lg-5" id="detail-product">
            <div class="product-info">
                <div class="element-header">
                    <h2 itemprop="name" class="display-6">${product.name}</h2>
                </div>
                
                <div class="product-price pt-3 pb-3">
                    <strong class="text-primary display-6 fw-bold">
                        <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" />đ
                    </strong>
                    <del class="ms-2">
                        <fmt:formatNumber value="${product.originalPrice}" type="number" groupingUsed="true" />đ
                    </del>
                </div>
            
                <div class="cart-wrap py-5">
                    <div class="color-options product-select">
                        <div class="color-toggle">
                            <h6 class="item-title text-uppercase text-dark">Phân loại</h6>
                            <ul class="select-list list-unstyled d-flex">
                                <li value="soft" class="select-item pe-3">
                                    <a href="#" class="btn btn-light active">Bìa mềm</a>
                                </li>
                                <li value="hard" class="select-item pe-3">
                                    <a href="#" class="btn btn-light">Bìa cứng</a>
                                </li>
                            </ul>
                        </div>
                    </div>
            
                    <div class="product-quantity pt-3">
                        <div class="stock-number text-dark">
                            <em>Còn ${product.quantityAvailable} sản phẩm</em>
                        </div>
            
                        <div class="stock-button-wrap">
                            <div class="input-group product-qty" style="max-width: 150px;">
                                <span class="input-group-btn">
                                    <button class="quantity-left-minus btn btn-light btn-number">-</button>
                                </span>
                                <input id="quantity-${product.id}" name="quantity" class="form-control input-number text-center"
                                       value="1" max="100" min="1" />
                                <span class="input-group-btn">
                                    <button class="quantity-right-plus btn btn-light btn-number">+</button>
                                </span>
                            </div>
                        </div>
                    </div>
            
                    <div class="qty-button d-flex flex-wrap pt-3">
                        <button type="submit" class="btn btn-primary py-3 px-4 text-uppercase me-3 mt-3">Mua ngay</button>
                        <button type="submit" class="btn btn-dark py-3 px-4 text-uppercase mt-3">
                            Thêm vào giỏ hàng
                        </button>
                    </div>
                </div>
            </div>
    </div>
  </div>
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-12">
        <h2 class="section-title">Mô tả sản phẩm</h2>
        <div id="description-product">
            <section class="product-info-tabs py-5">
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
                                            ${product.description}
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
                                                <li class="select-item">${product.productCode}</li>
                                            </ul>
                                        </div>
                                        <div class="meta-item d-flex align-items-baseline">
                                            <h6 class="item-title no-margin pe-2">Tên nhà cung cấp:</h6>
                                            <ul class="select-list list-unstyled d-flex">
                                                <li class="select-item"><a href="#">${product.supplier}</a></li>
                                            </ul>
                                        </div>
                                        <div class="meta-item d-flex align-items-baseline">
                                            <h6 class="item-title no-margin pe-2">Tác giả:</h6>
                                            <ul class="select-list list-unstyled d-flex">
                                                <li class="select-item">${product.author}</li>
                                            </ul>
                                        </div>
                                        <div class="meta-item d-flex align-items-baseline">
                                            <h6 class="item-title no-margin pe-2">Ngôn ngữ:</h6>
                                            <ul class="select-list list-unstyled d-flex">
                                                <li class="select-item">${product.language}</li>
                                            </ul>
                                        </div>
                                        <div class="meta-item d-flex align-items-baseline">
                                            <h6 class="item-title no-margin pe-2">NXB:</h6>
                                            <ul class="select-list list-unstyled d-flex">
                                                <li class="select-item">${product.publisher}</li>
                                            </ul>
                                        </div>
                                        <div class="meta-item d-flex align-items-baseline">
                                            <h6 class="item-title no-margin pe-2">Năm XB:</h6>
                                            <ul class="select-list list-unstyled d-flex">
                                                <li class="select-item">${product.publishYear}</li>
                                            </ul>
                                        </div>
                                        <div class="meta-item d-flex align-items-baseline">
                                            <h6 class="item-title no-margin pe-2">Trọng lượng:</h6>
                                            <ul class="select-list list-unstyled d-flex">
                                                <li class="select-item">${product.weight}g</li>
                                            </ul>
                                        </div>
                                        <div class="meta-item d-flex align-items-baseline">
                                            <h6 class="item-title no-margin pe-2">Số trang:</h6>
                                            <ul class="select-list list-unstyled d-flex">
                                                <li class="select-item">${product.quantityOfPages} tờ</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
  </div>
  <div class="container-fluid">

    <div class="row">
      <div class="col-md-12">

        <div class="section-header d-flex justify-content-between my-5">
          
          <h2 class="section-title">Sản phẩm liên quan</h2>

          <div class="d-flex align-items-center">
            <div class="swiper-buttons">
              <button class="swiper-prev products-carousel-prev btn btn-primary swiper-button-disabled" tabindex="-1" aria-label="Previous slide" aria-controls="swiper-wrapper-27c5ac6294c32634" aria-disabled="true" disabled="">❮</button>
              <button class="swiper-next products-carousel-next btn btn-primary" tabindex="0" aria-label="Next slide" aria-controls="swiper-wrapper-27c5ac6294c32634" aria-disabled="false">❯</button>
            </div>  
          </div>
        </div>
        
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">

        <div class="products-carousel swiper swiper-initialized swiper-horizontal swiper-backface-hidden">
          <div class="swiper-wrapper" id="swiper-wrapper-27c5ac6294c32634" aria-live="polite" style="transition-duration: 0ms; transform: translate3d(0px, 0px, 0px);">
          </div>
        <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
        <!-- / products-carousel -->

      </div>
    </div>
    
  </div>
  </section>
    <footer class="py-5">
      <div class="container-fluid">
        <div class="row">

          <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="footer-menu">
              <img src="images/logo.png" alt="logo" style="height: 100px;">
              <div class="social-links mt-5">
                <ul class="d-flex list-unstyled gap-2">
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"><path fill="currentColor" d="M15.12 5.32H17V2.14A26.11 26.11 0 0 0 14.26 2c-2.72 0-4.58 1.66-4.58 4.7v2.62H6.61v3.56h3.07V22h3.68v-9.12h3.06l.46-3.56h-3.52V7.05c0-1.05.28-1.73 1.76-1.73Z"/></svg>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"><path fill="currentColor" d="M22.991 3.95a1 1 0 0 0-1.51-.86a7.48 7.48 0 0 1-1.874.794a5.152 5.152 0 0 0-3.374-1.242a5.232 5.232 0 0 0-5.223 5.063a11.032 11.032 0 0 1-6.814-3.924a1.012 1.012 0 0 0-.857-.365a.999.999 0 0 0-.785.5a5.276 5.276 0 0 0-.242 4.769l-.002.001a1.041 1.041 0 0 0-.496.89a3.042 3.042 0 0 0 .027.439a5.185 5.185 0 0 0 1.568 3.312a.998.998 0 0 0-.066.77a5.204 5.204 0 0 0 2.362 2.922a7.465 7.465 0 0 1-3.59.448A1 1 0 0 0 1.45 19.3a12.942 12.942 0 0 0 7.01 2.061a12.788 12.788 0 0 0 12.465-9.363a12.822 12.822 0 0 0 .535-3.646l-.001-.2a5.77 5.77 0 0 0 1.532-4.202Zm-3.306 3.212a.995.995 0 0 0-.234.702c.01.165.009.331.009.488a10.824 10.824 0 0 1-.454 3.08a10.685 10.685 0 0 1-10.546 7.93a10.938 10.938 0 0 1-2.55-.301a9.48 9.48 0 0 0 2.942-1.564a1 1 0 0 0-.602-1.786a3.208 3.208 0 0 1-2.214-.935q.224-.042.445-.105a1 1 0 0 0-.08-1.943a3.198 3.198 0 0 1-2.25-1.726a5.3 5.3 0 0 0 .545.046a1.02 1.02 0 0 0 .984-.696a1 1 0 0 0-.4-1.137a3.196 3.196 0 0 1-1.425-2.673c0-.066.002-.133.006-.198a13.014 13.014 0 0 0 8.21 3.48a1.02 1.02 0 0 0 .817-.36a1 1 0 0 0 .206-.867a3.157 3.157 0 0 1-.087-.729a3.23 3.23 0 0 1 3.226-3.226a3.184 3.184 0 0 1 2.345 1.02a.993.993 0 0 0 .921.298a9.27 9.27 0 0 0 1.212-.322a6.681 6.681 0 0 1-1.026 1.524Z"/></svg>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"><path fill="currentColor" d="M23 9.71a8.5 8.5 0 0 0-.91-4.13a2.92 2.92 0 0 0-1.72-1A78.36 78.36 0 0 0 12 4.27a78.45 78.45 0 0 0-8.34.3a2.87 2.87 0 0 0-1.46.74c-.9.83-1 2.25-1.1 3.45a48.29 48.29 0 0 0 0 6.48a9.55 9.55 0 0 0 .3 2a3.14 3.14 0 0 0 .71 1.36a2.86 2.86 0 0 0 1.49.78a45.18 45.18 0 0 0 6.5.33c3.5.05 6.57 0 10.2-.28a2.88 2.88 0 0 0 1.53-.78a2.49 2.49 0 0 0 .61-1a10.58 10.58 0 0 0 .52-3.4c.04-.56.04-3.94.04-4.54ZM9.74 14.85V8.66l5.92 3.11c-1.66.92-3.85 1.96-5.92 3.08Z"/></svg>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"><path fill="currentColor" d="M17.34 5.46a1.2 1.2 0 1 0 1.2 1.2a1.2 1.2 0 0 0-1.2-1.2Zm4.6 2.42a7.59 7.59 0 0 0-.46-2.43a4.94 4.94 0 0 0-1.16-1.77a4.7 4.7 0 0 0-1.77-1.15a7.3 7.3 0 0 0-2.43-.47C15.06 2 14.72 2 12 2s-3.06 0-4.12.06a7.3 7.3 0 0 0-2.43.47a4.78 4.78 0 0 0-1.77 1.15a4.7 4.7 0 0 0-1.15 1.77a7.3 7.3 0 0 0-.47 2.43C2 8.94 2 9.28 2 12s0 3.06.06 4.12a7.3 7.3 0 0 0 .47 2.43a4.7 4.7 0 0 0 1.15 1.77a4.78 4.78 0 0 0 1.77 1.15a7.3 7.3 0 0 0 2.43.47C8.94 22 9.28 22 12 22s3.06 0 4.12-.06a7.3 7.3 0 0 0 2.43-.47a4.7 4.7 0 0 0 1.77-1.15a4.85 4.85 0 0 0 1.16-1.77a7.59 7.59 0 0 0 .46-2.43c0-1.06.06-1.4.06-4.12s0-3.06-.06-4.12ZM20.14 16a5.61 5.61 0 0 1-.34 1.86a3.06 3.06 0 0 1-.75 1.15a3.19 3.19 0 0 1-1.15.75a5.61 5.61 0 0 1-1.86.34c-1 .05-1.37.06-4 .06s-3 0-4-.06a5.73 5.73 0 0 1-1.94-.3a3.27 3.27 0 0 1-1.1-.75a3 3 0 0 1-.74-1.15a5.54 5.54 0 0 1-.4-1.9c0-1-.06-1.37-.06-4s0-3 .06-4a5.54 5.54 0 0 1 .35-1.9A3 3 0 0 1 5 5a3.14 3.14 0 0 1 1.1-.8A5.73 5.73 0 0 1 8 3.86c1 0 1.37-.06 4-.06s3 0 4 .06a5.61 5.61 0 0 1 1.86.34a3.06 3.06 0 0 1 1.19.8a3.06 3.06 0 0 1 .75 1.1a5.61 5.61 0 0 1 .34 1.9c.05 1 .06 1.37.06 4s-.01 3-.06 4ZM12 6.87A5.13 5.13 0 1 0 17.14 12A5.12 5.12 0 0 0 12 6.87Zm0 8.46A3.33 3.33 0 1 1 15.33 12A3.33 3.33 0 0 1 12 15.33Z"/></svg>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"><path fill="currentColor" d="M1.04 17.52q.1-.16.32-.02a21.308 21.308 0 0 0 10.88 2.9a21.524 21.524 0 0 0 7.74-1.46q.1-.04.29-.12t.27-.12a.356.356 0 0 1 .47.12q.17.24-.11.44q-.36.26-.92.6a14.99 14.99 0 0 1-3.84 1.58A16.175 16.175 0 0 1 12 22a16.017 16.017 0 0 1-5.9-1.09a16.246 16.246 0 0 1-4.98-3.07a.273.273 0 0 1-.12-.2a.215.215 0 0 1 .04-.12Zm6.02-5.7a4.036 4.036 0 0 1 .68-2.36A4.197 4.197 0 0 1 9.6 7.98a10.063 10.063 0 0 1 2.66-.66q.54-.06 1.76-.16v-.34a3.562 3.562 0 0 0-.28-1.72a1.5 1.5 0 0 0-1.32-.6h-.16a2.189 2.189 0 0 0-1.14.42a1.64 1.64 0 0 0-.62 1a.508.508 0 0 1-.4.46L7.8 6.1q-.34-.08-.34-.36a.587.587 0 0 1 .02-.14a3.834 3.834 0 0 1 1.67-2.64A6.268 6.268 0 0 1 12.26 2h.5a5.054 5.054 0 0 1 3.56 1.18a3.81 3.81 0 0 1 .37.43a3.875 3.875 0 0 1 .27.41a2.098 2.098 0 0 1 .18.52q.08.34.12.47a2.856 2.856 0 0 1 .06.56q.02.43.02.51v4.84a2.868 2.868 0 0 0 .15.95a2.475 2.475 0 0 0 .29.62q.14.19.46.61a.599.599 0 0 1 .12.32a.346.346 0 0 1-.16.28q-1.66 1.44-1.8 1.56a.557.557 0 0 1-.58.04q-.28-.24-.49-.46t-.3-.32a4.466 4.466 0 0 1-.29-.39q-.2-.29-.28-.39a4.91 4.91 0 0 1-2.2 1.52a6.038 6.038 0 0 1-1.68.2a3.505 3.505 0 0 1-2.53-.95a3.553 3.553 0 0 1-.99-2.69Zm3.44-.4a1.895 1.895 0 0 0 .39 1.25a1.294 1.294 0 0 0 1.05.47a1.022 1.022 0 0 0 .17-.02a1.022 1.022 0 0 1 .15-.02a2.033 2.033 0 0 0 1.3-1.08a3.13 3.13 0 0 0 .33-.83a3.8 3.8 0 0 0 .12-.73q.01-.28.01-.92v-.5a7.287 7.287 0 0 0-1.76.16a2.144 2.144 0 0 0-1.76 2.22Zm8.4 6.44a.626.626 0 0 1 .12-.16a3.14 3.14 0 0 1 .96-.46a6.52 6.52 0 0 1 1.48-.22a1.195 1.195 0 0 1 .38.02q.9.08 1.08.3a.655.655 0 0 1 .08.36v.14a4.56 4.56 0 0 1-.38 1.65a3.84 3.84 0 0 1-1.06 1.53a.302.302 0 0 1-.18.08a.177.177 0 0 1-.08-.02q-.12-.06-.06-.22a7.632 7.632 0 0 0 .74-2.42a.513.513 0 0 0-.08-.32q-.2-.24-1.12-.24q-.34 0-.8.04q-.5.06-.92.12a.232.232 0 0 1-.16-.04a.065.065 0 0 1-.02-.08a.153.153 0 0 1 .02-.06Z"/></svg>
                    </a>
                  </li>
                </ul>
              </div>
            </div>
          </div>

          <div class="col-md-2 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Ultras</h5>
              <ul class="menu-list list-unstyled">
                <li class="menu-item">
                  <a href="#" class="nav-link">About us</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Conditions </a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Our Journals</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Careers</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Affiliate Programme</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Ultras Press</a>
                </li>
              </ul>
            </div>
          </div>
          <div class="col-md-2 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Customer Service</h5>
              <ul class="menu-list list-unstyled">
                <li class="menu-item">
                  <a href="#" class="nav-link">FAQ</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Contact</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Privacy Policy</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Returns & Refunds</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Cookie Guidelines</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Delivery Information</a>
                </li>
              </ul>
            </div>
          </div>
          <div class="col-md-2 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Customer Service</h5>
              <ul class="menu-list list-unstyled">
                <li class="menu-item">
                  <a href="#" class="nav-link">FAQ</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Contact</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Privacy Policy</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Returns & Refunds</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Cookie Guidelines</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Delivery Information</a>
                </li>
              </ul>
            </div>
          </div>
          <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Subscribe Us</h5>
              <p>Subscribe to our newsletter to get updates about our grand offers.</p>
              <form class="d-flex mt-3 gap-0" role="newsletter">
                <input class="form-control rounded-start rounded-0 bg-light" type="email" placeholder="Email Address" aria-label="Email Address">
                <button class="btn btn-dark rounded-end rounded-0" type="submit">Subscribe</button>
              </form>
            </div>
          </div>
          
        </div>
      </div>
    </footer>
    <div id="footer-bottom">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-6 copyright">
            <p>© 2023 Foodmart. All rights reserved.</p>
          </div>
          <div class="col-md-6 credit-link text-start text-md-end">
            <p>Free HTML Template by <a href="https://templatesjungle.com/">TemplatesJungle</a> Distributed by <a href="https://themewagon">ThemeWagon</a></p>
          </div>
        </div>
      </div>
      <div id="toast-container"></div>
    </div>
    <script src="/js/user/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="/js/user/plugins.js"></script>
    <script src="/js/user/script.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="/js/user/detail-product.js"></script>
    <script src="/js/user/toast.js"></script>
    <script src="/js/user/cart.js"></script>
    <script src="/js/user/list-book.js"></script>
    <!-- Alpine Plugins -->
<script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/collapse@3.x.x/dist/cdn.min.js"></script>
 
<!-- Alpine Core -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
  </body>
</html>