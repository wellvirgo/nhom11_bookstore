<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Đăng ký</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="/images/favicon.png" rel="icon">
    <link href="/images/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link
            href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
            rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="/css/admin/style.css" rel="stylesheet">
    <style>
        .error {
            color: red;
        }
    </style>
</head>

<body>

<main>
    <div class="container">

        <section
                class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
            <div class="container">
                <div class="row justify-content-center">
                    <div
                            class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

                        <div class="d-flex justify-content-center py-4">
                            <a href="index.html" class="logo d-flex align-items-center w-auto">
                                <img src="/images/logo.png" alt="">
                                <span class="d-none d-lg-block">BookStore</span>
                            </a>
                        </div><!-- End Logo -->

                        <div class="card mb-3">

                            <div class="card-body">

                                <div class="pt-4 pb-2">
                                    <h5 class="card-title text-center pb-0 fs-4">Đăng ký tài khoản</h5>
                                    <p class="text-center small">Nhập thông tin tạo tài khoản</p>
                                </div>

                                <!-- If email has been registered, display error message -->
                                <c:if test="${errMessage!=null}">
                                    <div class="alert alert-danger" role="alert">
                                            ${errMessage}
                                    </div>
                                </c:if>

                                <%--@elvariable id="userCreation"
                                    type="com.nhom11.Book_Store.dto.UserCreation" --%>
                                <form:form method="post" action="/register"
                                           modelAttribute="userCreation" class="row g-3 needs-validation"
                                           novalidate="novalidate">
                                    <input type="hidden" name="${_csrf.parameterName}"
                                           value="${_csrf.token}"/>

                                    <div class="col-12">
                                        <label for="yourEmail" class="form-label">Email</label>
                                        <form:input path="email" type="email" name="email"
                                                    class="form-control" id="yourEmail"
                                                    required="required"/>
                                        <div class="invalid-feedback">Vui lòng nhập email hợp lệ!</div>
                                        <!-- If email is incorrect format, display error message -->
                                        <form:errors path="email" cssClass="error"/>
                                    </div>

                                    <div class="col-12">
                                        <label for="yourPassword"
                                               class="form-label">Mật khẩu</label>
                                        <form:password path="password" name="password"
                                                       cssClass="form-control" id="yourPassword"
                                                       required="required"/>
                                        <div class="invalid-feedback">Vui lòng nhập mật khẩu!
                                        </div>
                                        <!-- If password is weak, display error message-->
                                        <form:errors path="password" cssClass="error"/>
                                    </div>

                                    <div class="col-12">
                                        <button class="btn btn-primary w-100" type="submit">
                                            Đăng ký
                                        </button>
                                    </div>
                                    <div class="col-12">
                                        <p class="small mb-0">Đã có tài khoản? <a
                                                href="/login">Đăng nhập</a></p>
                                    </div>
                                </form:form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </section>

    </div>
</main><!-- End #main -->

<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
        class="bi bi-arrow-up-short"></i></a>

<!-- Vendor JS Files -->
<script src="/vendor/apexcharts/apexcharts.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/vendor/chart.js/chart.umd.js"></script>
<script src="/vendor/echarts/echarts.min.js"></script>
<script src="/vendor/quill/quill.js"></script>
<script src="/vendor/simple-datatables/simple-datatables.js"></script>
<script src="/vendor/tinymce/tinymce.min.js"></script>
<script src="/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="/js/admin/main.js"></script>

</body>

</html>