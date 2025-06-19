<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>404 - Không tìm thấy trang</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        background-color: #f8f9fa;
        font-family: "Nunito", sans-serif;
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0;
        padding: 20px;
      }
      .error-container {
        text-align: center;
        max-width: 600px;
        padding: 40px;
        background: white;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      }
      .error-code {
        font-size: 120px;
        font-weight: 700;
        color: #ffc43f;
        line-height: 1;
        margin-bottom: 20px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
      }
      .error-message {
        font-size: 24px;
        color: #343a40;
        margin-bottom: 30px;
      }
      .error-description {
        color: #6c757d;
        margin-bottom: 30px;
        font-size: 16px;
      }
      .btn-home {
        background-color: #ffc43f;
        color: white;
        padding: 12px 30px;
        border-radius: 25px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-block;
        margin: 10px;
      }
      .btn-home:hover {
        background-color: #ffc43f;
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);
      }
      .btn-back {
        background-color: #6c757d;
        color: white;
        padding: 12px 30px;
        border-radius: 25px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-block;
        margin: 10px;
      }
      .btn-back:hover {
        background-color: #5a6268;
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(108, 117, 125, 0.3);
      }
      .error-image {
        max-width: 300px;
        margin-bottom: 30px;
      }
      .search-box {
        margin: 30px 0;
        position: relative;
      }
      .search-box input {
        width: 100%;
        padding: 15px 20px;
        border: 2px solid #e9ecef;
        border-radius: 25px;
        font-size: 16px;
        transition: all 0.3s ease;
      }
      .search-box input:focus {
        outline: none;
        border-color: #ffc43f;
        box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
      }
      .search-box button {
        position: absolute;
        right: 5px;
        top: 50%;
        transform: translateY(-50%);
        background: #ffc43f;
        border: none;
        color: white;
        padding: 10px 20px;
        border-radius: 20px;
        cursor: pointer;
        transition: all 0.3s ease;
      }
      .search-box button:hover {
        background: #ffc43f;
      }
      @media (max-width: 576px) {
        .error-code {
          font-size: 80px;
        }
        .error-message {
          font-size: 20px;
        }
        .error-container {
          padding: 20px;
        }
      }
    </style>
  </head>
  <body>
    <div class="error-container">
      <div class="d-flex justify-content-center align-items-center">
        <img src="/images/logo.png" height="54" width="54" alt="404 Error" />
        <div class="border-start mx-3" style="height: 100px"></div>
        <div class="error-code">404</div>
      </div>

      <h1 class="error-message">Oops! Không tìm thấy trang</h1>
      <p class="error-description">
        Trang bạn đang tìm kiếm có thể đã bị xóa, đổi tên hoặc tạm thời không
        khả dụng.
      </p>

      <div class="search-box">
        <form action="/user/search" method="GET">
          <input
            type="text"
            name="keyword"
            placeholder="Tìm kiếm sản phẩm..."
            required
          />
          <button type="submit">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              fill="currentColor"
              class="bi bi-search"
              viewBox="0 0 16 16"
            >
              <path
                d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"
              />
            </svg>
          </button>
        </form>
      </div>

      <div class="button-group">
        <a href="/user/home" class="btn-home">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="16"
            height="16"
            fill="currentColor"
            class="bi bi-house-door"
            viewBox="0 0 16 16"
            style="margin-right: 8px"
          >
            <path
              d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"
            />
          </svg>
          Về trang chủ
        </a>
        <a href="javascript:history.back()" class="btn-back">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="16"
            height="16"
            fill="currentColor"
            class="bi bi-arrow-left"
            viewBox="0 0 16 16"
            style="margin-right: 8px"
          >
            <path
              fill-rule="evenodd"
              d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"
            />
          </svg>
          Quay lại
        </a>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
