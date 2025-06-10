<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Chỉnh sửa sách - BookStore Admin</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="/images/favicon.png" rel="icon">
    <link href="/images/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
          referrerpolicy="no-referrer"/>

    <!-- Vendor CSS Files -->
    <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="/vendor/remixicon/remixicon.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="/css/admin/style.css" rel="stylesheet">
    <link href="/css/admin/add-book.css" rel="stylesheet">

    <style>
        .error {
            color: red;
        }

        .old-img-container {
            width: 100px;
            height: 100px;
            overflow: hidden;
            border: 1px solid #ddd;
            border-radius: 0.375rem;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .old-img-preview-square {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .img-clickable {
            cursor: pointer;
        }
    </style>
</head>

<body>
<!-- Header -->
<jsp:include page="../layout/header.jsp"/>

<!-- Sidebar -->
<jsp:include page="../layout/sidebar.jsp"/>

<!-- Main Content -->
<main id="main" class="main">
    <div class="pagetitle">
        <h1>Chỉnh sửa sách</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/admin/das">Trang chủ</a></li>
                <li class="breadcrumb-item">Quản lý sách</li>
                <li class="breadcrumb-item active">Chỉnh sửa sách</li>
            </ol>
        </nav>
<%--        <div class="d-flex gap-4">--%>
<%--            <div class="form-check">--%>
<%--                <input class="form-check-input" type="radio" name="radioDefault" id="rdBusinessActive">--%>
<%--                <label class="form-check-label" for="rdBusinessActive">--%>
<%--                    Đang kinh doanh--%>
<%--                </label>--%>
<%--            </div>--%>
<%--            <div class="form-check">--%>
<%--                <input class="form-check-input" type="radio" name="radioDefault" id="rdBusinessInActive" checked>--%>
<%--                <label class="form-check-label" for="rdBusinessInActive">--%>
<%--                    Ngừng kinh doanh--%>
<%--                </label>--%>
<%--            </div>--%>
<%--        </div>--%>
    </div>

    <c:if test="${status eq 'success'}">
        <div
                class="toast align-items-center text-bg-success border-0 position-fixed top-2 end-0 z-3 fade"
                role="alert" aria-live="assertive" aria-atomic="true"
                data-bs-autohide="true" data-bs-delay="2000">
            <div class="d-flex">
                <div class="toast-body">
                    Cập nhật sách thành công!
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                        aria-label="Close"></button>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                let toastEl = document.querySelector('.toast');
                if (toastEl) {
                    let toast = new bootstrap.Toast(toastEl);
                    toast.show();
                }
            });
        </script>
    </c:if>
    <c:if test="${status eq 'error'}">
        <div
                class="toast align-items-center text-bg-danger border-0 position-fixed top-2 end-0 z-3 fade"
                role="alert" aria-live="assertive" aria-atomic="true"
                data-bs-autohide="true" data-bs-delay="2000">
            <div class="d-flex">
                <div class="toast-body">
                    Có lỗi khi cập nhật sách!
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                        aria-label="Close"></button>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                let toastEl = document.querySelector('.toast');
                if (toastEl) {
                    let toast = new bootstrap.Toast(toastEl);
                    toast.show();
                }
            });
        </script>
    </c:if>

    <div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content bg-transparent border-0">
                <div class="modal-body text-center p-0">
                    <img id="modalImage" src="" alt="Phóng to ảnh" class="img-fluid rounded shadow">
                </div>
            </div>
        </div>
    </div>

    <section class="section">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body pt-3">
                        <!-- Toolbar -->
                        <!-- Tabs -->
                        <ul class="nav nav-tabs nav-tabs-bordered">
                            <li class="nav-item">
                                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#book-info">Thông
                                    tin
                                    sách
                                </button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#book-description">Mô
                                    tả
                                </button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#book-images">Hình
                                    ảnh
                                </button>
                            </li>
                        </ul>

                        <%--@elvariable id="book" type="com.nhom11.Book_Store.dto.ProductCreation"--%>
                        <form:form id="form-create"
                                   action="/admin/edit-book/${id}" method="post"
                                   class="needs-validation" novalidate="novalidate"
                                   modelAttribute="book"
                                   enctype="multipart/form-data">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <div class="tab-content pt-4">
                                <!-- Book Info Tab -->
                                <div class="tab-pane fade show active" id="book-info">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label for="bookTitle" class="form-label">Tên sách <span
                                                    class="text-danger">*</span></label>
                                            <form:input path="name"
                                                        type="text" class="form-control" id="bookTitle"
                                                        required="required"/>
                                            <div class="invalid-feedback">Vui lòng nhập tên sách!</div>
                                            <form:errors path="name" cssClass="error"/>
                                        </div>

                                        <div class="col-md-6">
                                            <label for="author" class="form-label">Tác giả <span
                                                    class="text-danger">*</span></label>
                                            <form:input path="author"
                                                        type="text" class="form-control" id="author"
                                                        required="required"/>
                                            <div class="invalid-feedback">Vui lòng nhập tên tác giả!</div>
                                        </div>

                                        <div class="col-md-6">
                                            <label for="supplier" class="form-label">Nhà cung cấp <span
                                                    class="text-danger">*</span></label>
                                            <form:select path="supplier"
                                                         class="form-select" id="supplier" required="required">
                                                <option selected disabled value="">-- Chọn nhà cung cấp --</option>
                                                <form:options items="${suppliers}"/>
                                            </form:select>
                                            <div class="invalid-feedback">Vui lòng chọn nhà cung cấp!</div>
                                            <form:errors path="supplier" cssClass="error"/>
                                        </div>

                                        <div class="col-md-6">
                                            <label for="publisher" class="form-label">Nhà xuất bản <span
                                                    class="text-danger">*</span></label>
                                            <form:select path="publisher"
                                                         class="form-select" id="publisher" required="required">
                                                <option selected disabled value="">-- Chọn nhà xuất bản --</option>
                                                <form:options items="${publishers}"/>
                                            </form:select>
                                            <div class="invalid-feedback">Vui lòng chọn nhà xuất bản!</div>
                                            <form:errors path="publisher" cssClass="error"/>
                                        </div>

                                        <div class="col-md-4">
                                            <label for="coverType" class="form-label">Hình thức bìa</label>
                                            <form:select path="book_layout"
                                                         class="form-select" id="coverType">
                                                <option selected disabled value="">-- Chọn hình thức bìa --</option>
                                                <form:option value="Bìa cứng">Bìa cứng</form:option>
                                                <form:option value="Bìa mềm">Bìa mềm</form:option>
                                                <form:option value="CD/USB">CD/USB</form:option>
                                                <form:option value="Tạp chí">Tạp chí</form:option>
                                            </form:select>
                                        </div>

                                        <div class="col-md-4">
                                            <label for="price" class="form-label">Giá bán <span
                                                    class="text-danger">*</span></label>
                                            <div class="input-group">
                                                <form:input path="price"
                                                            type="number" class="form-control number-input" id="price"
                                                            required="required"/>
                                                <span class="input-group-text">VNĐ</span>
                                            </div>
                                            <div class="invalid-feedback">Vui lòng nhập giá bán!</div>
                                            <form:errors path="price" cssClass="error"/>
                                        </div>

                                        <div class="col-md-4">
                                            <label for="publishYear" class="form-label">Năm xuất bản <span
                                                    class="text-danger">*</span></label>
                                            <form:input path="publishYear"
                                                        type="number" class="form-control number-input" id="publishYear"
                                                        min="1000"
                                                        max="2099" placeholder="VD: 2023" required="required"/>
                                            <form:errors path="publisher" cssClass="error"/>
                                            <div class="invalid-feedback">Vui lòng kiểm tra lại năm xuất bản!</div>
                                            <form:errors path="publishYear" cssClass="error"/>
                                        </div>

                                        <div class="col-md-4">
                                            <label for="language" class="form-label">Ngôn ngữ</label>
                                            <form:select path="language"
                                                         class="form-select" id="language">
                                                <form:option selected="selected"
                                                             value="Tiếng Việt">Tiếng Việt</form:option>
                                                <form:option value="Tiếng Anh">Tiếng Anh</form:option>
                                                <form:option
                                                        value="Song ngữ Việt - Anh">Song ngữ Việt - Anh</form:option>
                                                <form:option value="Tiếng Pháp">Tiếng Pháp</form:option>
                                                <form:option value="Tiếng Nhật">Tiếng Nhật</form:option>
                                                <form:option value="Tiếng Hàn">Tiếng Hàn</form:option>
                                                <form:option value="Tiếng Trung">Tiếng Trung</form:option>
                                            </form:select>
                                        </div>

                                        <div class="col-md-4">
                                            <label for="weight" class="form-label">Khối lượng (gram) <span
                                                    class="text-danger">*</span></label>
                                            <form:input path="weight"
                                                        type="number" class="form-control number-input" id="weight"
                                                        min="1" required="required"
                                                        placeholder="VD: 350"/>
                                            <div class="invalid-feedback">Vui lòng kiểm tra lại khối lượng!</div>
                                            <form:errors path="weight" cssClass="error"/>
                                        </div>

                                        <div class="col-md-4">
                                            <label for="size" class="form-label">Kích thước</label>
                                            <form:input path="size"
                                                        type="text" class="form-control" id="size"
                                                        placeholder="VD: 14 x 20.5 cm"/>
                                        </div>

                                        <div class="col-md-4">
                                            <label for="pageCount" class="form-label">Số trang <span
                                                    class="text-danger">*</span></label>
                                            <form:input path="quantityPage"
                                                        type="number" class="form-control number-input" id="pageCount"
                                                        min="1" required="required"
                                                        placeholder="VD: 256"/>
                                            <div class="invalid-feedback">Vui lòng kiểm tra lại số trang!</div>
                                            <form:errors path="quantityPage" cssClass="error"/>
                                        </div>

                                        <div class="col-md-4">
                                            <label for="inventory" class="form-label">Số lượng <span
                                                    class="text-danger">*</span></label>
                                            <form:input path="quantityAvailable"
                                                        min="1"
                                                        type="number" class="form-control number-input" id="inventory"
                                                        required="required"
                                                        placeholder="VD: 100"/>
                                            <div class="invalid-feedback">Vui lòng nhập số lượng tồn kho!</div>
                                            <form:errors path="quantityAvailable" cssClass="error"/>
                                        </div>

                                        <div class="col-md-4">
                                            <label for="category" class="form-label">Thể loại <span
                                                    class="text-danger">*</span></label>
                                            <form:select path="genreName"
                                                         class="form-select" id="category" required="required">
                                                <option selected disabled value="">-- Chọn thể loại --</option>
                                                <c:forEach var="genreName" items="${genreNames}">
                                                    <form:option value="${genreName}">${genreName}</form:option>
                                                </c:forEach>
                                            </form:select>
                                            <div class="invalid-feedback">Vui lòng chọn thể loại!</div>
                                            <form:errors path="genreName" cssClass="error"/>
                                        </div>
                                    </div>
                                    <div class="text-end mt-4">
                                        <button type="button" class="btn btn-primary next-tab">Tiếp theo</button>
                                    </div>
                                </div>

                                <!-- Book Description Tab -->
                                <div class="tab-pane fade" id="book-description">
                                    <div class="mb-3">
                                        <label for="fullDescription" class="form-label">Mô tả chi tiết</label>
                                        <div id="editor" style="height: 300px;"></div>
                                        <form:input path="description"
                                                    type="hidden" id="fullDescription"/>
                                    </div>
                                    <div class="d-flex justify-content-between mt-4">
                                        <button type="button" class="btn btn-secondary prev-tab">Quay lại</button>
                                        <button type="button" class="btn btn-primary next-tab">Tiếp theo</button>
                                    </div>
                                </div>

                                <!-- Book Images Tab -->
                                <div class="tab-pane fade" id="book-images">
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <p class="fw-bold text-center">Ảnh bìa hiện tại</p>
                                            <c:if test="${not empty coverImg}">
                                                <div class="old-img-container mx-auto">
                                                    <img src="${coverImg}" alt="Ảnh bìa"
                                                         class="old-img-preview-square img-clickable"
                                                         data-bs-toggle="modal"
                                                         data-bs-target="#imageModal"
                                                         data-img-src="${backImg}">
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="col-md-6">
                                            <p class="fw-bold text-center">Ảnh bìa sau hiện tại</p>
                                            <c:if test="${not empty backImg}">
                                                <div class="old-img-container mx-auto">
                                                    <img src="${backImg}" alt="Ảnh bìa sau"
                                                         class="old-img-preview-square img-clickable"
                                                         data-bs-toggle="modal"
                                                         data-bs-target="#imageModal"
                                                         data-img-src="${backImg}">
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <p class="fw-bold">Các ảnh khác hiện tại</p>
                                        <div class="col-12 d-flex gap-2">
                                            <c:if test="${not empty additionalImgMap}">
                                                <c:forEach var="item" items="${additionalImgMap}">
                                                    <div class="old-img-container">
                                                        <img src="${item.value}" alt=""
                                                             class="old-img-preview-square img-clickable"
                                                             data-bs-toggle="modal"
                                                             data-bs-target="#imageModal"
                                                             data-img-src="${item.value}">
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <label for="coverImage" class="form-label fw-bold">Ảnh bìa sách</label>
                                            <div class="image-upload-container">
                                                <div class="upload-area" id="coverImageUpload">
                                                    <i class="bi bi-cloud-arrow-up fs-1"></i>
                                                    <p>Kéo thả ảnh vào đây hoặc <span class="text-primary">Chọn
                                                                        tệp</span></p>
                                                    <p class="text-muted small">JPG, PNG hoặc WEBP (max. 2MB)</p>
                                                    <input type="file" id="coverImage" name="coverImage"
                                                           class="file-input"
                                                           accept="image/*" hidden>
                                                </div>
                                                <div id="coverPreview" class="image-preview"></div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <label for="backCoverImage" class="form-label fw-bold">Ảnh bìa sau (tùy
                                                chọn)</label>
                                            <div class="image-upload-container">
                                                <div class="upload-area" id="backCoverImageUpload">
                                                    <i class="bi bi-cloud-arrow-up fs-1"></i>
                                                    <p>Kéo thả ảnh vào đây hoặc <span class="text-primary">Chọn
                                                                        tệp</span></p>
                                                    <p class="text-muted small">JPG, PNG hoặc WEBP (max. 2MB)</p>
                                                    <input type="file" id="backCoverImage" name="backCoverImage"
                                                           class="file-input"
                                                           accept="image/*" hidden>
                                                </div>
                                                <div id="backCoverPreview" class="image-preview"></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="additional-images mb-4">
                                        <label for="additionalImages" class="form-label fw-bold">Ảnh bổ sung (tối đa 5
                                            ảnh)</label>
                                        <div class="upload-area" id="additionalImagesUpload">
                                            <i class="bi bi-images fs-1"></i>
                                            <p>Kéo thả nhiều ảnh vào đây hoặc <span class="text-primary">Chọn
                                                                tệp</span>
                                            </p>
                                            <p class="text-muted small">JPG, PNG hoặc WEBP (max. 2MB/ảnh)</p>
                                            <input type="file" id="additionalImages" name="additionalImages"
                                                   class="file-input"
                                                   accept="image/*" multiple hidden>
                                        </div>
                                        <div id="additionalPreview" class="multiple-image-preview mt-3"></div>
                                    </div>

                                    <div class="d-flex justify-content-between mt-4">
                                        <button type="button" class="btn btn-secondary prev-tab">Quay lại</button>
                                        <div>
                                            <a href="/admin/list-books" type="button"
                                               class="btn btn-secondary me-2">Hủy</a>
                                            <button type="submit" class="btn btn-success">Cập nhật</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- Footer -->
<jsp:include page="../layout/footer.jsp"/>

<!-- Vendor JS Files -->
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/vendor/quill/quill.js"></script>
<script src="/vendor/tinymce/tinymce.min.js"></script>

<!-- Template JS Files -->
<script src="/js/admin/main.js"></script>

<script>

    document.addEventListener('DOMContentLoaded', function () {
        var additionalFiles = [];
        // Initialize Quill editor
        var quill = new Quill('#editor', {
            theme: 'snow',
            placeholder: 'Nhập mô tả chi tiết về sách...',
            modules: {
                toolbar: [
                    ['bold', 'italic', 'underline', 'strike'],
                    ['blockquote', 'code-block'],
                    [{'header': 1}, {'header': 2}],
                    [{'list': 'ordered'}, {'list': 'bullet'}],
                    [{'indent': '-1'}, {'indent': '+1'}],
                    [{'direction': 'rtl'}],
                    [{'size': ['small', false, 'large', 'huge']}],
                    [{'color': []}, {'background': []}],
                    [{'align': []}],
                    ['clean']
                ]
            }
        });
        quill.root.innerHTML = "${book.getDescription()}";

        // Tab navigation buttons
        document.querySelectorAll('.next-tab').forEach(button => {
            button.addEventListener('click', function () {
                const currentTab = this.closest('.tab-pane');
                const nextTabId = currentTab.nextElementSibling.id;
                document.querySelector('[data-bs-target="#' + nextTabId + '"]').click();

            });
        });

        document.querySelectorAll('.prev-tab').forEach(button => {
            button.addEventListener('click', function () {
                const currentTab = this.closest('.tab-pane');
                const prevTabId = currentTab.previousElementSibling.id;
                document.querySelector('[data-bs-target="#' + prevTabId + '"]').click();
            });
        });

        // Image upload functionality
        const setupImageUpload = (uploadAreaId, inputId, previewId, multiple = false) => {
            const uploadArea = document.getElementById(uploadAreaId);
            const input = document.getElementById(inputId);
            const preview = document.getElementById(previewId);

            uploadArea.addEventListener('click', () => input.click());

            uploadArea.addEventListener('dragover', (e) => {
                e.preventDefault();
                uploadArea.classList.add('active');
            });

            uploadArea.addEventListener('dragleave', () => {
                uploadArea.classList.remove('active');
            });

            uploadArea.addEventListener('drop', (e) => {
                e.preventDefault();
                uploadArea.classList.remove('active');

                if (multiple) {
                    handleFiles(Array.from(e.dataTransfer.files), preview);
                } else {
                    handleFile(e.dataTransfer.files[0], preview);
                }
            });

            input.addEventListener('change', () => {
                if (multiple) {
                    handleFiles(Array.from(input.files), preview);
                } else {
                    handleFile(input.files[0], preview);
                }
            });
        };

        const handleFile = (file, preview) => {
            if (!file || !file.type.startsWith('image/')) return;

            const reader = new FileReader();
            reader.onload = (e) => {
                preview.innerHTML = '';
                const img = document.createElement('div');
                img.className = 'preview-item';
                img.innerHTML =
                    '<img src="' + e.target.result + '" alt="Preview">' +
                    '<button type="button" class="remove-btn"><i class="bi bi-x"></i></button>';
                preview.appendChild(img);

                img.querySelector('.remove-btn').addEventListener('click', () => {
                    preview.innerHTML = '';
                    document.getElementById('coverImage').value = '';
                });
            };
            reader.readAsDataURL(file);
        };

        const handleFiles = (files, preview) => {
            if (!files.length) return;

            const remainingSlots = 5 - additionalFiles.length;
            const filesToProcess = files.slice(0, remainingSlots);

            filesToProcess.forEach(file => {
                if (!file.type.startsWith('image/')) return;

                additionalFiles.push(file); // Lưu file vào mảng
                const reader = new FileReader();

                reader.onload = (e) => {
                    const img = document.createElement('div');
                    img.className = 'preview-item';
                    img.innerHTML =
                        '<img src="' + e.target.result + '" alt="Preview">' +
                        '<button type="button" class="remove-btn"><i class="bi bi-x"></i></button>';
                    preview.appendChild(img);

                    img.querySelector('.remove-btn').addEventListener('click', () => {
                        img.remove();
                        const index = additionalFiles.indexOf(file);
                        if (index > -1) additionalFiles.splice(index, 1);
                    });
                };
                reader.readAsDataURL(file);
            });

            console.log('Ảnh bổ sung đã chọn:', additionalFiles);
        };

        // Setup upload cho từng loại ảnh
        setupImageUpload('coverImageUpload', 'coverImage', 'coverPreview');
        setupImageUpload('backCoverImageUpload', 'backCoverImage', 'backCoverPreview');
        setupImageUpload('additionalImagesUpload', 'additionalImages', 'additionalPreview', true);

        // Form submit
        document.querySelector('#form-create').addEventListener('submit', function (e) {
            e.preventDefault();

            const form = this;

            // Kiểm tra validation
            if (!form.checkValidity()) {
                alert("Có lỗi dữ liệu nhập vào, vui lòng kiểm tra lại")
                const currentUrl = window.location.href.split('#')[0];
                window.location.href = currentUrl + '#';
                form.classList.add('was-validated');
                return;
            }

            // Nếu hợp lệ, tiến hành xử lý nội dung quill và gửi dữ liệu
            form.classList.add('was-validated');
            document.getElementById('fullDescription').value = quill.root.innerHTML;

            const formData = new FormData(form);

            // Thêm ảnh bổ sung vào formData
            additionalFiles.forEach(file => {
                formData.append('additionalImages', file);
            });

            console.log('FormData chuẩn bị gửi:');
            for (let pair of formData.entries()) {
                console.log(pair[0], pair[1]);
            }

            fetch(form.action, {
                method: 'POST',
                body: formData
            })
                .then(response => {
                    if (response.redirected) {
                        window.location.href = response.url;
                    } else {
                        return response.text();
                    }
                })
                .catch(err => {
                    console.error('Lỗi:', err);
                });
        });

        document.querySelectorAll('.number-input').forEach(input => {
            input.addEventListener('input', function () {
                let value = input.value;
                if (isNaN(value) || value < 0) {
                    input.value = 0;
                }
            });

            input.addEventListener('keyup', (e) => {
                if (e.key === '-' || e.keyCode === 189) {
                    input.value = 0;
                }
            });

            input.addEventListener('blur', (e) => {
                if (input.value === "")
                    input.value = 0;
            });

            input.addEventListener('focus', function () {
                if (Number.parseInt(input.value) === 0)
                    input.value = "";
            });
        });

        const imageModal = document.getElementById('imageModal');
        const modalImage = document.getElementById('modalImage');

        imageModal.addEventListener('show.bs.modal', function (event) {
            const triggerImg = event.relatedTarget;
            const imgSrc = triggerImg.getAttribute('data-img-src');
            modalImage.src = imgSrc;
        });

    });
</script>
</body>

</html>