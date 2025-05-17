%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Book store</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="author" content="" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />

    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
      crossorigin="anonymous"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="<c:url value='/css/user/vendor.css'/>"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="<c:url value='/css/user/style.css'/>"
    />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Open+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap"
      rel="stylesheet"
    />
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet" />
  </head>
  <body>
    <div
      class="offcanvas offcanvas-end"
      data-bs-scroll="true"
      tabindex="-1"
      id="offcanvasCart"
      aria-labelledby="My Cart"
    >
      <div class="offcanvas-header justify-content-center">
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="offcanvas"
          aria-label="Close"
        ></button>
      </div>
      <div class="offcanvas-body">
        <div class="order-md-last">
          <h4 class="d-flex justify-content-between align-items-center mb-3">
            <span class="text-primary">Giỏ hàng của tôi</span>
            <span
              class="badge bg-primary rounded-pill"
              id="cart-quantity"
            ></span>
          </h4>
          <ul class="list-group mb-3" id="offcanvas-cart">
            <li class="list-group-item d-flex justify-content-between">
              <span>Total (USD)</span>
              <strong>$20</strong>
            </li>
          </ul>
          <button class="w-100 btn btn-primary btn-lg" type="submit">
            <a href="<c:url value='/cart.jsp'/>" class="nav-link"
              >Xem giỏ hàng</a
            >
          </button>
        </div>
      </div>
    </div>

    <div
      class="offcanvas offcanvas-end"
      data-bs-scroll="true"
      tabindex="-1"
      id="offcanvasSearch"
      aria-labelledby="Search"
    >
      <div class="offcanvas-header justify-content-center">
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="offcanvas"
          aria-label="Close"
        ></button>
      </div>
      <div class="offcanvas-body">
        <div class="order-md-last">
          <h4 class="d-flex justify-content-between align-items-center mb-3">
            <span class="text-primary">Search</span>
          </h4>
          <form
            role="search"
            action="<c:url value='/home.jsp'/>"
            method="get"
            class="d-flex mt-3 gap-0"
          >
            <input
              class="form-control rounded-start rounded-0 bg-light"
              type="email"
              placeholder="What are you looking for?"
              aria-label="What are you looking for?"
            />
            <button class="btn btn-dark rounded-end rounded-0" type="submit">
              Search
            </button>
          </form>
        </div>
      </div>
    </div>

    <header>
      <div class="container-fluid">
        <div class="row py-3 border-bottom">
          <div
            class="col-sm-4 col-lg-3 text-center text-sm-start d-flex justify-content-sm-start justify-content-center"
          >
            <div class="main-logo d-flex align-items-center">
              <a href="<c:url value='/user/home.jsp'/>">
                <img
                  src="<c:url value='/images/book-shop.png'/>"
                  alt="logo"
                  height="54"
                />
              </a>
            </div>
            <div class="d-flex align-items-center ms-1">
              <span
                ><span style="color: #222; font-size: 25px">Book</span
                ><span style="color: #fdc650; font-size: 25px"
                  >Store</span
                ></span
              >
            </div>
          </div>

          <div
            class="col-sm-6 offset-sm-2 offset-md-0 col-lg-5 d-none d-lg-block"
          >
            <div
              class="search-bar row bg-light p-2 my-2 rounded-4 justify-content-between"
            >
              <div class="col-md-11">
                <form
                  id="search-form"
                  class="text-center"
                  action="<c:url value='/user/home.jsp'/>"
                  method="post"
                >
                  <input
                    type="text"
                    class="form-control border-0 bg-transparent"
                    id="menusearch"
                    placeholder="Search for more than 20,000 products"
                  />
                </form>
              </div>
              <div class="col-1">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                >
                  <path
                    fill="currentColor"
                    d="M21.71 20.29L18 16.61A9 9 0 1 0 16.61 18l3.68 3.68a1 1 0 0 0 1.42 0a1 1 0 0 0 0-1.39ZM11 18a7 7 0 1 1 7-7a7 7 0 0 1-7 7Z"
                  />
                </svg>
              </div>
            </div>
          </div>

          <div
            class="col-sm-8 col-lg-4 d-flex justify-content-end gap-5 align-items-center mt-4 mt-sm-0 justify-content-center justify-content-sm-end"
          >
            <ul class="d-flex justify-content-end list-unstyled m-0">
              <li>
                <a
                  href="#"
                  class="rounded-circle bg-light p-2 mx-1 position-relative"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="24"
                    height="24"
                    fill="currentColor"
                    class="bi bi-bell"
                    viewBox="0 0 16 16"
                  >
                    <path
                      d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2M8 1.918l-.797.161A4 4 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4 4 0 0 0-3.203-3.92zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5 5 0 0 1 13 6c0 .88.32 4.2 1.22 6"
                    />
                  </svg>
                  <span
                    class="position-absolute top-0 start-100 translate-middle badge rounded-pill"
                    style="background-color: #ffc43f"
                  >
                    <%-- Có thể thay thế bằng một biến động từ backend --%>
                    <c:set var="notificationCount" value="4" />
                    <c:out value="${notificationCount}" />
                    <span class="visually-hidden">unread messages</span>
                  </span>
                </a>
              </li>
              <li>
                <a href="#" class="rounded-circle bg-light p-2 mx-1">
                  <svg width="24" height="24" viewBox="0 0 24 24">
                    <use xlink:href="#heart"></use>
                  </svg>
                </a>
              </li>
              <li class="">
                <a
                  href="#"
                  class="rounded-circle bg-light p-2 mx-1 position-relative"
                  data-bs-toggle="offcanvas"
                  data-bs-target="#offcanvasCart"
                  aria-controls="offcanvasCart"
                >
                  <svg width="24" height="24" viewBox="0 0 24 24">
                    <use xlink:href="#cart"></use>
                  </svg>
                  <span
                    class="position-absolute top-0 start-100 translate-middle badge rounded-pill"
                    style="background-color: #ffc43f"
                    id="cart-quantity-header"
                  >
                    <%-- Có thể lấy từ session hoặc request attribute --%>
                    <c:set
                      var="cartQuantity"
                      value="${sessionScope.cartQuantity != null ? sessionScope.cartQuantity : 0}"
                    />
                    <c:out value="${cartQuantity}" />
                    <span class="visually-hidden">unread messages</span>
                  </span>
                </a>
              </li>
              <li>
                <a
                  href="<c:url value='/user.jsp'/>"
                  class="rounded-circle bg-light p-2 mx-1"
                >
                  <svg width="24" height="24" viewBox="0 0 24 24">
                    <use xlink:href="#user"></use>
                  </svg>
                </a>
              </li>
              <li class="d-lg-none">
                <a
                  href="#"
                  class="rounded-circle bg-light p-2 mx-1"
                  data-bs-toggle="offcanvas"
                  data-bs-target="#offcanvasSearch"
                  aria-controls="offcanvasSearch"
                >
                  <svg width="24" height="24" viewBox="0 0 24 24">
                    <use xlink:href="#search"></use>
                  </svg>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="container-fluid">
        <div class="row py-3">
          <div
            class="d-flex justify-content-center justify-content-sm-between align-items-center"
          >
            <nav class="main-menu d-flex navbar navbar-expand-lg">
              <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="offcanvas"
                data-bs-target="#offcanvasNavbar"
                aria-controls="offcanvasNavbar"
              >
                <span class="navbar-toggler-icon"></span>
              </button>

              <div
                class="offcanvas offcanvas-end"
                tabindex="-1"
                id="offcanvasNavbar"
                aria-labelledby="offcanvasNavbarLabel"
              >
                <div class="offcanvas-header justify-content-center">
                  <button
                    type="button"
                    class="btn-close"
                    data-bs-dismiss="offcanvas"
                    aria-label="Close"
                  ></button>
                </div>
              </div>
            </nav>
          </div>
        </div>
      </div>
    </header>

    <%-- Thêm phần nội dung chính của trang ở đây --%>
    <main><%-- Nội dung chính của trang có thể đặt ở đây --%></main>

    <%-- Scripts --%>
    <script src="/js/user/jquery-3.7.1.min.js"></script>
    <script src="/js/user/index.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
      crossorigin="anonymous"
    ></script>
    <script src="js/user/plugins.js"></script>
    <script src="js/user/script.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="/js/user/cart.js"></script>
  </body>
</html>
