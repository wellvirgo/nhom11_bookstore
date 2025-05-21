<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Book Store</title>
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
    <link rel="stylesheet" type="text/css" href="css/vendor.css">
    <link rel="stylesheet" type="text/css" href="style.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Open+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
  </head>
  <body>
    <div class="preloader-wrapper">
      <div class="preloader">
      </div>
    </div>

    <jsp:include page="header.jsp" />
    <section class="py-3 mb-5" style="background-image: url('images/background-pattern.jpg');background-repeat: no-repeat;background-size: cover;">
        <div class="container-fluid">
          <div class="d-flex justify-content-between">
            <h1 class="page-title pb-2">Sản phẩm</h1>
            <nav class="breadcrumb fs-6">
              <a class="breadcrumb-item nav-link" href="index.html">Home</a>
              <span class="breadcrumb-item active" href="list-book.html">Sản phẩm</span>
            </nav>
          </div>
        </div>
    
    </section>
    <section class="">
      <div class="shopify-grid">
      <div class="container-fluid" data-aos="fade-up">
        
        <div class="row">
          <aside class="col-md-2">
            <div class="sidebar">
              <div class="widget-menu">
                <div class="widget-search-bar">
                  <form role="search" method="get" class="d-flex position-relative">
                    <input class="form-control form-control-lg rounded-2 bg-light" type="email" placeholder="search here" >
                    <button class="btn bg-transparent position-absolute end-0"></button>
                  </form>
                </div>
              </div>
              <div class="widget-product-categories pt-5">
                <h5 class="widget-title">Thể loại</h5>
                <ul class="product-categories sidebar-list list-unstyled">
                  <li class="cat-item">ALL</li>
                  <li class="cat-item">ALL</li>
                  <li class="cat-item">ALL</li>
                  <li class="cat-item">ALL</li>
                  <li class="cat-item">ALL</li>
                </ul>
              </div>
              <div class="widget-product-categories pt-3">
                <h5 class="widget-title">Nhà cung cấp</h5>
                <ul class="product-categories sidebar-list list-unstyled">
                  <li class="cat-item">ALL</li>
                  <li class="cat-item">ALL</li>
                  <li class="cat-item">ALL</li>
                  <li class="cat-item">ALL</li>
                  <li class="cat-item">ALL</li>
                </ul>
              </div>
              <div class="widget-product-categories pt-3">
                <h5 class="widget-title">Giá</h5>
                <ul class="product-categories sidebar-list list-unstyled">
                  <li class="cat-item">ALL</li>
                  <li class="cat-item">ALL</li>
                  <li class="cat-item">ALL</li>
                  <li class="cat-item">ALL</li>
                  <li class="cat-item">ALL</li>
                </ul>
              </div>
            </div>
          </aside>
          <main class="col-md-10">

            <div class="bootstrap-tabs product-tabs">
              <div class="filter-shop d-flex justify-content-between">
                <div class="showing-product">
                  <p>Showing 1-9 of 55 results</p>
                </div>
                <div class="sort-by">
                  <select id="input-sort" class="form-control">
                    <option>Default sorting</option>
                    <option>Name (A - Z)</option>
                    <option>Name (Z - A)</option>
                    <option>Price (Low-High)</option>
                    <option>Price (High-Low)</option>
                    <option>Rating (Highest)</option>
                    <option>Rating (Lowest)</option>
                  </select>
                </div>
             
              </div>
              <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-all" role="tabpanel" aria-labelledby="nav-all-tab" >
                  <div id="empty-item" class="d-flex justify-content-center"></div>
                  <div class="product-grid row row-cols-sm-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4" id="product-item"> 
                    <c:forEach var="item" items="${bookList}">
    <div class="col" data-aos="zoom-out" data-aos-delay="200">
      <div class="product-item">
        <span class="badge bg-success position-absolute m-3">-30%</span>
        <a href="#" class="btn-wishlist">
          <svg width="24" height="24"><use xlink:href="#heart"></use></svg>
        </a>
        <figure>
          <a href="detail-product.jsp?id=${item.id}" title="Product Title">
            <img src="${item.image}" alt="${item.name}" class="tab-image">
          </a>
        </figure>
        <h3 style="min-height: 50px;" class="item-name">${item.name}</h3>
        <span class="qty">1 Unit</span>
        <span class="rating">
          <svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> ${item.averageRating}
        </span>
        <div class="d-flex">
          <span class="price">
            <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/>đ
          </span>
          <span class="qty" style="text-decoration: line-through;">
            <fmt:formatNumber value="${item.originalPrice}" type="number" groupingUsed="true"/>
          </span>
        </div>
        <div class="d-xxl-flex align-items-center justify-content-between">
          <div class="input-group product-qty">
            <span class="input-group-btn">
              <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus">
                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
              </button>
            </span>
            <input type="text" id="quantity-${item.id}" name="quantity"
                   class="form-control input-number" value="1">
            <span class="input-group-btn">
              <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus">
                <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
              </button>
            </span>
          </div>
          <a href="#" class="nav-link"onclick="">Thêm vào giỏ hàng<iconify-icon icon="uil:shopping-cart"></iconify-icon>
          </a>
        </div>
      </div>
    </div>
  </c:forEach>          
                  </div>
                  <!-- / product-grid -->
                  <nav class="text-center py-4">
                    <ul class="pagination d-flex justify-content-center">
                      <li class="page-item disabled">
                        <a class="page-link bg-none border-0" href="#"><span>«</span></a>
                      </li>
                      <li class="page-item active"><a class="page-link border-0">1</a></li>
                      <li class="page-item "><a class="page-link border-0">2</a></li>
                      <li class="page-item "><a class="page-link border-0">3</a></li>
                      <li class="page-item disabled">
                        <a class="page-link bg-none border-0" href="#"><span>»</span></a>
                      </li>
                    </ul>
                  </nav>
                </div>

                <div class="tab-pane fade" id="nav-fruits" role="tabpanel" aria-labelledby="nav-fruits-tab">
                  
                  <div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5">

                    <div class="col">
                      <div class="product-item">
                        <span class="badge bg-success position-absolute m-3">-30%</span>
                        <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                        <figure>
                          <a href="index.html" title="Product Title">
                            <img src="images/thumb-cucumber.png"  class="tab-image">
                          </a>
                        </figure>
                        <h3>Sunstar Fresh Melon Juice</h3>
                        <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                        <span class="price">$18.00</span>
                        <div class="d-flex align-items-center justify-content-between">
                          <div class="input-group product-qty">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus">
                                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                                  </button>
                              </span>
                              <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus">
                                      <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                                  </button>
                              </span>
                          </div>
                          <a href="#" class="nav-link">Add to Cart <iconify-icon icon="uil:shopping-cart"></iconify-icon></a>
                        </div>
                      </div>
                    </div>

                    <div class="col">
                      <div class="product-item">
                        <span class="badge bg-success position-absolute m-3">-30%</span>
                        <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                        <figure>
                          <a href="index.html" title="Product Title">
                            <img src="images/thumb-milk.png"  class="tab-image">
                          </a>
                        </figure>
                        <h3>Sunstar Fresh Melon Juice</h3>
                        <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                        <span class="price">$18.00</span>
                        <div class="d-flex align-items-center justify-content-between">
                          <div class="input-group product-qty">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus">
                                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                                  </button>
                              </span>
                              <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus">
                                      <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                                  </button>
                              </span>
                          </div>
                          <a href="#" class="nav-link">Add to Cart <iconify-icon icon="uil:shopping-cart"></a>
                        </div>
                      </div>
                    </div>
                  
                    <div class="col">
                      <div class="product-item">
                        <span class="badge bg-success position-absolute m-3">-30%</span>
                        <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                        <figure>
                          <a href="index.html" title="Product Title">
                            <img src="images/thumb-orange-juice.png"  class="tab-image">
                          </a>
                        </figure>
                        <h3>Sunstar Fresh Melon Juice</h3>
                        <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                        <span class="price">$18.00</span>
                        <div class="d-flex align-items-center justify-content-between">
                          <div class="input-group product-qty">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus">
                                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                                  </button>
                              </span>
                              <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus">
                                      <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                                  </button>
                              </span>
                          </div>
                          <a href="#" class="nav-link">Add to Cart <iconify-icon icon="uil:shopping-cart"></a>
                        </div>
                      </div>
                    </div>

                    <div class="col">
                      <div class="product-item">
                        <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                        <figure>
                          <a href="index.html" title="Product Title">
                            <img src="images/thumb-raspberries.png"  class="tab-image">
                          </a>
                        </figure>
                        <h3>Sunstar Fresh Melon Juice</h3>
                        <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                        <span class="price">$18.00</span>
                        <div class="d-flex align-items-center justify-content-between">
                          <div class="input-group product-qty">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus">
                                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                                  </button>
                              </span>
                              <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus">
                                      <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                                  </button>
                              </span>
                          </div>
                          <a href="#" class="nav-link">Add to Cart <iconify-icon icon="uil:shopping-cart"></a>
                        </div>
                      </div>
                    </div>

                    <div class="col">
                      <div class="product-item">
                        <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                        <figure>
                          <a href="index.html" title="Product Title">
                            <img src="images/thumb-bananas.png"  class="tab-image">
                          </a>
                        </figure>
                        <h3>Sunstar Fresh Melon Juice</h3>
                        <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                        <span class="price">$18.00</span>
                        <div class="d-flex align-items-center justify-content-between">
                          <div class="input-group product-qty">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus">
                                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                                  </button>
                              </span>
                              <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus">
                                      <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                                  </button>
                              </span>
                          </div>
                          <a href="#" class="nav-link">Add to Cart <iconify-icon icon="uil:shopping-cart"></a>
                        </div>
                      </div>
                    </div>

                    <div class="col">
                      <div class="product-item">
                        <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                        <figure>
                          <a href="index.html" title="Product Title">
                            <img src="images/thumb-bananas.png"  class="tab-image">
                          </a>
                        </figure>
                        <h3>Sunstar Fresh Melon Juice</h3>
                        <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                        <span class="price">$18.00</span>
                        <div class="d-flex align-items-center justify-content-between">
                          <div class="input-group product-qty">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus">
                                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                                  </button>
                              </span>
                              <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus">
                                      <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                                  </button>
                              </span>
                          </div>
                          <a href="#" class="nav-link">Add to Cart <iconify-icon icon="uil:shopping-cart"></a>
                        </div>
                      </div>
                    </div>
                  </div>
                  </div>
                  <!-- / product-grid -->

                </div>
                <div class="tab-pane fade" id="nav-juices" role="tabpanel" aria-labelledby="nav-juices-tab">

                  <div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5">

                    <div class="col">
                      <div class="product-item">
                        <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                        <figure>
                          <a href="index.html" title="Product Title">
                            <img src="images/thumb-cucumber.png"  class="tab-image">
                          </a>
                        </figure>
                        <h3>Sunstar Fresh Melon Juice</h3>
                        <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                        <span class="price">$18.00</span>
                        <div class="d-flex align-items-center justify-content-between">
                          <div class="input-group product-qty">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus">
                                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                                  </button>
                              </span>
                              <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus">
                                      <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                                  </button>
                              </span>
                          </div>
                          <a href="#" class="nav-link">Add to Cart <iconify-icon icon="uil:shopping-cart"></a>
                        </div>
                      </div>
                    </div>

                    <div class="col">
                      <div class="product-item">
                        <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                        <figure>
                          <a href="index.html" title="Product Title">
                            <img src="images/thumb-milk.png"  class="tab-image">
                          </a>
                        </figure>
                        <h3>Sunstar Fresh Melon Juice</h3>
                        <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                        <span class="price">$18.00</span>
                        <div class="d-flex align-items-center justify-content-between">
                          <div class="input-group product-qty">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus">
                                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                                  </button>
                              </span>
                              <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus">
                                      <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                                  </button>
                              </span>
                          </div>
                          <a href="#" class="nav-link">Add to Cart <iconify-icon icon="uil:shopping-cart"></a>
                        </div>
                      </div>
                    </div>
                  
                    <div class="col">
                      <div class="product-item">
                        <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                        <figure>
                          <a href="index.html" title="Product Title">
                            <img src="images/thumb-tomatoes.png"  class="tab-image">
                          </a>
                        </figure>
                        <h3>Sunstar Fresh Melon Juice</h3>
                        <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                        <span class="price">$18.00</span>
                        <div class="d-flex align-items-center justify-content-between">
                          <div class="input-group product-qty">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus">
                                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                                  </button>
                              </span>
                              <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus">
                                      <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                                  </button>
                              </span>
                          </div>
                          <a href="#" class="nav-link">Add to Cart <iconify-icon icon="uil:shopping-cart"></a>
                        </div>
                      </div>
                    </div>

                    <div class="col">
                      <div class="product-item">
                        <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                        <figure>
                          <a href="index.html" title="Product Title">
                            <img src="images/thumb-tomatoketchup.png"  class="tab-image">
                          </a>
                        </figure>
                        <h3>Sunstar Fresh Melon Juice</h3>
                        <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                        <span class="price">$18.00</span>
                        <div class="d-flex align-items-center justify-content-between">
                          <div class="input-group product-qty">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus">
                                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                                  </button>
                              </span>
                              <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus">
                                      <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                                  </button>
                              </span>
                          </div>
                          <a href="#" class="nav-link">Add to Cart <iconify-icon icon="uil:shopping-cart"></a>
                        </div>
                      </div>
                    </div>

                    <div class="col">
                      <div class="product-item">
                        <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                        <figure>
                          <a href="index.html" title="Product Title">
                            <img src="images/thumb-bananas.png"  class="tab-image">
                          </a>
                        </figure>
                        <h3>Sunstar Fresh Melon Juice</h3>
                        <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                        <span class="price">$18.00</span>
                        <div class="d-flex align-items-center justify-content-between">
                          <div class="input-group product-qty">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus">
                                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                                  </button>
                              </span>
                              <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus">
                                      <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                                  </button>
                              </span>
                          </div>
                          <a href="#" class="nav-link">Add to Cart <iconify-icon icon="uil:shopping-cart"></a>
                        </div>
                      </div>
                    </div>

                    <div class="col">
                      <div class="product-item">
                        <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                        <figure>
                          <a href="index.html" title="Product Title">
                            <img src="images/thumb-bananas.png"  class="tab-image">
                          </a>
                        </figure>
                        <h3>Sunstar Fresh Melon Juice</h3>
                        <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                        <span class="price">$18.00</span>
                        <div class="d-flex align-items-center justify-content-between">
                          <div class="input-group product-qty">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus">
                                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                                  </button>
                              </span>
                              <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus">
                                      <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                                  </button>
                              </span>
                          </div>
                          <a href="#" class="nav-link">Add to Cart <iconify-icon icon="uil:shopping-cart"></a>
                        </div>
                      </div>
                    </div>

                  </div>
                  <!-- / product-grid -->
                  
                </div>
                
              </div>
            </main>

          </div>
        
      </div>
    </div>
    </section>

    <section class="py-5">
      <div class="container-fluid" data-aos="fade-up">
        <div class="row">
          
          <div class="col-md-6">
            <div class="banner-ad bg-danger mb-3" style="background: url('images/ad-image-3.png');background-repeat: no-repeat;background-position: right bottom;">
              <div class="banner-content p-5">

                <div class="categories text-primary fs-3 fw-bold">Upto 25% Off</div>
                <h3 class="banner-title">Luxa Dark Chocolate</h3>
                <p>Very tasty & creamy vanilla flavour creamy muffins.</p>
                <a href="#" class="btn btn-dark text-uppercase">Show Now</a>

              </div>
            
            </div>
          </div>
          <div class="col-md-6">
            <div class="banner-ad bg-info" style="background: url('images/ad-image-4.png');background-repeat: no-repeat;background-position: right bottom;">
              <div class="banner-content p-5">

                <div class="categories text-primary fs-3 fw-bold">Upto 25% Off</div>
                <h3 class="banner-title">Creamy Muffins</h3>
                <p>Very tasty & creamy vanilla flavour creamy muffins.</p>
                <a href="#" class="btn btn-dark text-uppercase">Show Now</a>

              </div>
            
            </div>
          </div>
             
        </div>
      </div>
    </section>
    <section class="py-5">
      <div class="container-fluid" data-aos="fade-up">

        <div class="bg-secondary py-5 my-5 rounded-5" style="background: url('images/bg-leaves-img-pattern.png') no-repeat;">
          <div class="container my-5">
            <div class="row">
              <div class="col-md-6 p-5">
                <div class="section-header">
                  <h2 class="section-title display-4">Get <span class="text-primary">25% Discount</span> on your first purchase</h2>
                </div>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dictumst amet, metus, sit massa posuere maecenas. At tellus ut nunc amet vel egestas.</p>
              </div>
              <div class="col-md-6 p-5">
                <form>
                  <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input type="text"
                      class="form-control form-control-lg" name="name" id="name" placeholder="Name">
                  </div>
                  <div class="mb-3">
                    <label for="" class="form-label">Email</label>
                    <input type="email" class="form-control form-control-lg" name="email" id="email" placeholder="abc@mail.com">
                  </div>
                  <div class="form-check form-check-inline mb-3">
                    <label class="form-check-label" for="subscribe">
                    <input class="form-check-input" type="checkbox" id="subscribe" value="subscribe">
                    Subscribe to the newsletter</label>
                  </div>
                  <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-dark btn-lg">Submit</button>
                  </div>
                </form>
                
              </div>
              
            </div>
            
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
    <script src="js/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="js/plugins.js"></script>
    <script src="js/script.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="js/list-book.js"></script>
    <script src="/js/toast.js"></script>
    <script src="js/cart.js"></script>
  </body>
</html>