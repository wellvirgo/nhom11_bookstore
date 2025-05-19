<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <svg xmlns="http://www.w3.org/2000/svg" style="display: none">
      <defs>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="link"
          viewBox="0 0 24 24"
        >
          <path
            fill="currentColor"
            d="M12 19a1 1 0 1 0-1-1a1 1 0 0 0 1 1Zm5 0a1 1 0 1 0-1-1a1 1 0 0 0 1 1Zm0-4a1 1 0 1 0-1-1a1 1 0 0 0 1 1Zm-5 0a1 1 0 1 0-1-1a1 1 0 0 0 1 1Zm7-12h-1V2a1 1 0 0 0-2 0v1H8V2a1 1 0 0 0-2 0v1H5a3 3 0 0 0-3 3v14a3 3 0 0 0 3 3h14a3 3 0 0 0 3-3V6a3 3 0 0 0-3-3Zm1 17a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-9h16Zm0-11H4V6a1 1 0 0 1 1-1h1v1a1 1 0 0 0 2 0V5h8v1a1 1 0 0 0 2 0V5h1a1 1 0 0 1 1 1ZM7 15a1 1 0 1 0-1-1a1 1 0 0 0 1 1Zm0 4a1 1 0 1 0-1-1a1 1 0 0 0 1 1Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="arrow-right"
          viewBox="0 0 24 24"
        >
          <path
            fill="currentColor"
            d="M17.92 11.62a1 1 0 0 0-.21-.33l-5-5a1 1 0 0 0-1.42 1.42l3.3 3.29H7a1 1 0 0 0 0 2h7.59l-3.3 3.29a1 1 0 0 0 0 1.42a1 1 0 0 0 1.42 0l5-5a1 1 0 0 0 .21-.33a1 1 0 0 0 0-.76Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="category"
          viewBox="0 0 24 24"
        >
          <path
            fill="currentColor"
            d="M19 5.5h-6.28l-.32-1a3 3 0 0 0-2.84-2H5a3 3 0 0 0-3 3v13a3 3 0 0 0 3 3h14a3 3 0 0 0 3-3v-10a3 3 0 0 0-3-3Zm1 13a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-13a1 1 0 0 1 1-1h4.56a1 1 0 0 1 .95.68l.54 1.64a1 1 0 0 0 .95.68h7a1 1 0 0 1 1 1Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="calendar"
          viewBox="0 0 24 24"
        >
          <path
            fill="currentColor"
            d="M19 4h-2V3a1 1 0 0 0-2 0v1H9V3a1 1 0 0 0-2 0v1H5a3 3 0 0 0-3 3v12a3 3 0 0 0 3 3h14a3 3 0 0 0 3-3V7a3 3 0 0 0-3-3Zm1 15a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-7h16Zm0-9H4V7a1 1 0 0 1 1-1h2v1a1 1 0 0 0 2 0V6h6v1a1 1 0 0 0 2 0V6h2a1 1 0 0 1 1 1Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="heart"
          viewBox="0 0 24 24"
        >
          <path
            fill="currentColor"
            d="M20.16 4.61A6.27 6.27 0 0 0 12 4a6.27 6.27 0 0 0-8.16 9.48l7.45 7.45a1 1 0 0 0 1.42 0l7.45-7.45a6.27 6.27 0 0 0 0-8.87Zm-1.41 7.46L12 18.81l-6.75-6.74a4.28 4.28 0 0 1 3-7.3a4.25 4.25 0 0 1 3 1.25a1 1 0 0 0 1.42 0a4.27 4.27 0 0 1 6 6.05Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="plus"
          viewBox="0 0 24 24"
        >
          <path
            fill="currentColor"
            d="M19 11h-6V5a1 1 0 0 0-2 0v6H5a1 1 0 0 0 0 2h6v6a1 1 0 0 0 2 0v-6h6a1 1 0 0 0 0-2Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="minus"
          viewBox="0 0 24 24"
        >
          <path
            fill="currentColor"
            d="M19 11H5a1 1 0 0 0 0 2h14a1 1 0 0 0 0-2Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="cart"
          viewBox="0 0 24 24"
        >
          <path
            fill="currentColor"
            d="M8.5 19a1.5 1.5 0 1 0 1.5 1.5A1.5 1.5 0 0 0 8.5 19ZM19 16H7a1 1 0 0 1 0-2h8.491a3.013 3.013 0 0 0 2.885-2.176l1.585-5.55A1 1 0 0 0 19 5H6.74a3.007 3.007 0 0 0-2.82-2H3a1 1 0 0 0 0 2h.921a1.005 1.005 0 0 1 .962.725l.155.545v.005l1.641 5.742A3 3 0 0 0 7 18h12a1 1 0 0 0 0-2Zm-1.326-9l-1.22 4.274a1.005 1.005 0 0 1-.963.726H8.754l-.255-.892L7.326 7ZM16.5 19a1.5 1.5 0 1 0 1.5 1.5a1.5 1.5 0 0 0-1.5-1.5Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="check"
          viewBox="0 0 24 24"
        >
          <path
            fill="currentColor"
            d="M18.71 7.21a1 1 0 0 0-1.42 0l-7.45 7.46l-3.13-3.14A1 1 0 1 0 5.29 13l3.84 3.84a1 1 0 0 0 1.42 0l8.16-8.16a1 1 0 0 0 0-1.47Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="trash"
          viewBox="0 0 24 24"
        >
          <path
            fill="currentColor"
            d="M10 18a1 1 0 0 0 1-1v-6a1 1 0 0 0-2 0v6a1 1 0 0 0 1 1ZM20 6h-4V5a3 3 0 0 0-3-3h-2a3 3 0 0 0-3 3v1H4a1 1 0 0 0 0 2h1v11a3 3 0 0 0 3 3h8a3 3 0 0 0 3-3V8h1a1 1 0 0 0 0-2ZM10 5a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v1h-4Zm7 14a1 1 0 0 1-1 1H8a1 1 0 0 1-1-1V8h10Zm-3-1a1 1 0 0 0 1-1v-6a1 1 0 0 0-2 0v6a1 1 0 0 0 1 1Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="star-outline"
          viewBox="0 0 15 15"
        >
          <path
            fill="none"
            stroke="currentColor"
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M7.5 9.804L5.337 11l.413-2.533L4 6.674l2.418-.37L7.5 4l1.082 2.304l2.418.37l-1.75 1.793L9.663 11L7.5 9.804Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="star-solid"
          viewBox="0 0 15 15"
        >
          <path
            fill="currentColor"
            d="M7.953 3.788a.5.5 0 0 0-.906 0L6.08 5.85l-2.154.33a.5.5 0 0 0-.283.843l1.574 1.613l-.373 2.284a.5.5 0 0 0 .736.518l1.92-1.063l1.921 1.063a.5.5 0 0 0 .736-.519l-.373-2.283l1.574-1.613a.5.5 0 0 0-.283-.844L8.921 5.85l-.968-2.062Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="search"
          viewBox="0 0 24 24"
        >
          <path
            fill="currentColor"
            d="M21.71 20.29L18 16.61A9 9 0 1 0 16.61 18l3.68 3.68a1 1 0 0 0 1.42 0a1 1 0 0 0 0-1.39ZM11 18a7 7 0 1 1 7-7a7 7 0 0 1-7 7Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="user"
          viewBox="0 0 24 24"
        >
          <path
            fill="currentColor"
            d="M15.71 12.71a6 6 0 1 0-7.42 0a10 10 0 0 0-6.22 8.18a1 1 0 0 0 2 .22a8 8 0 0 1 15.9 0a1 1 0 0 0 1 .89h.11a1 1 0 0 0 .88-1.1a10 10 0 0 0-6.25-8.19ZM12 12a4 4 0 1 1 4-4a4 4 0 0 1-4 4Z"
          />
        </symbol>
        <symbol
          xmlns="http://www.w3.org/2000/svg"
          id="close"
          viewBox="0 0 15 15"
        >
          <path
            fill="currentColor"
            d="M7.953 3.788a.5.5 0 0 0-.906 0L6.08 5.85l-2.154.33a.5.5 0 0 0-.283.843l1.574 1.613l-.373 2.284a.5.5 0 0 0 .736.518l1.92-1.063l1.921 1.063a.5.5 0 0 0 .736-.519l-.373-2.283l1.574-1.613a.5.5 0 0 0-.283-.844L8.921 5.85l-.968-2.062Z"
          />
        </symbol>
      </defs>
    </svg>

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
            >2</span>
          </h4>
          <ul class="list-group mb-3" id="offcanvas-cart">
            <c:forEach var="item" items="${cartItems}">
                <li class="list-group-item d-flex justify-content-between lh-sm">
                    <div class="d-flex flex-column justify-content-between">
                        <h6 class="my-0 item-name">${item.name}</h6>
                        <div class="d-flex justify-centent-between align-items-center">
                            <small class="text-body-secondary">
                                <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/>đ
                            </small>
                            <small class="text-body-secondary text-decoration-line-through ms-1" style="font-size:12px">
                                <fmt:formatNumber value="${item.originalPrice}" type="number" groupingUsed="true"/>đ
                            </small>
                        </div>
                    </div>
                    <img src="${item.image}" class="img-fluid" style="height:100px">
                </li>
            </c:forEach>
            
            <li class="list-group-item d-flex justify-content-between">
              <span>Total (USD)</span>
              <strong>$20</strong>
            </li>
          </ul>
          <button class="w-100 btn btn-primary btn-lg" type="submit">
            <a href="<c:url value='/cart'/>" class="nav-link"
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
              <a href="<c:url value='/home'/>">
                <img
                  src="<c:url value='/images/logo.png'/>"
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
                  action="<c:url value='/user'/>"
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
                  href="<c:url value='/user'/>"
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
