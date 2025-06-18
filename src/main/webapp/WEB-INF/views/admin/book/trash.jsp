<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Book trash - BookStore Admin</title>
    <meta content="" name="description">
    <meta content="" name="keywords">
    <!-- Favicons -->
    <link href="/images/favicon.png" rel="icon">
    <link href="/images/apple-touch-icon.png" rel="apple-touch-icon">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@200;300;400;500;600;700;800;900&display=swap"
          rel="stylesheet">
    <!-- Vendor CSS Files -->
    <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <!-- Template Main CSS File -->
    <link href="/css/admin/style.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.1/css/dataTables.dataTables.css"/>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.datatables.net/2.3.1/js/dataTables.js"></script>
</head>

<body>
<!-- Header Placeholder -->
<jsp:include page="../layout/header.jsp"/>
<!-- Sidebar Placeholder -->
<jsp:include page="../layout/sidebar.jsp"/>
<!-- Main Content -->
<main id="main" class="main">
    <!-- Orders List Content - System Style -->
    <div class="pagetitle">
        <h1>Thùng rác</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/admin/das">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="/admin/list-books">Quản lý sách</a></li>
                <li class="breadcrumb-item active">Thùng rác</li>
            </ol>
        </nav>
    </div>

    <!-- Toast when restore a book -->
    <c:if test="${isRestored == 1}">
        <div
                class="toast align-items-center text-bg-success border-0 position-fixed top-2 end-0 z-3 fade"
                role="alert" aria-live="assertive" aria-atomic="true"
                data-bs-autohide="true" data-bs-delay="4000">
            <div class="d-flex">
                <div class="toast-body">
                    Thực hiện khôi phục sách thành công!
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

    <!-- Toast when delete a book -->
    <c:if test="${isDeleted == 1}">
        <div
                class="toast align-items-center text-bg-success border-0 position-fixed top-2 end-0 z-3 fade"
                role="alert" aria-live="assertive" aria-atomic="true"
                data-bs-autohide="true" data-bs-delay="4000">
            <div class="d-flex">
                <div class="toast-body">
                    Thực hiện xóa sách thành công
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
    <c:if test="${isDeleted == 0}">
        <div
                class="toast align-items-center text-bg-danger border-0 position-fixed top-2 end-0 z-3 fade"
                role="alert" aria-live="assertive" aria-atomic="true"
                data-bs-autohide="true" data-bs-delay="4000">
            <div class="d-flex">
                <div class="toast-body">
                    Thực hiện xóa sách không thành công, vui lòng kiểm tra lại!
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

    <div class="card">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="card-title mb-0">Sách đã xóa</h5>
            </div>

            <!-- Del confirmation modal -->
            <div id="delModalConfirm" class="modal fade">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Xác nhận xóa</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body"></div>
                        <div class="modal-footer">
                            <form id="form-confirm-del" method="post">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button id="btn-confirm" class="btn btn-danger" type="submit"> Xác nhận</button>
                                <button class="btn btn-primary" type="button" data-bs-dismiss="modal">
                                    Hủy
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table id="bookTrashTable" class="table table-hover align-middle datatable table-striped">
                    <thead class="table-light">
                    <tr>
                        <th class="text-center">Mã sách</th>
                        <th>Tên sách</th>
                        <th class="text-center">Xóa sau</th>
                        <th class="text-center">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
            <div id="orders-pagination" class="mt-3"></div>
        </div>
    </div>
    <!-- End Main Content -->
</main>
<!-- Footer Placeholder -->
<jsp:include page="../layout/footer.jsp"/>
<!-- Vendor JS Files -->
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Template JS Files -->
<script src="/js/admin/main.js"></script>
<%
    ObjectMapper objectMapper = new ObjectMapper();
    String data = objectMapper.writeValueAsString(request.getAttribute("productInTrashes"));
%>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const tbody = document.getElementsByTagName('tbody').item(0);
        const bookTrashes =<%= data %>;
        bookTrashes.forEach(bookTrash => {
            const row = document.createElement('tr');
            row.innerHTML =
                '<td class="text-center">' + bookTrash.id + '</td>' +
                '<td>' + bookTrash.name + '</td>' +
                '<td class="text-center">' + bookTrash.deletedTime + ' ngày' + '</td>' +
                '<td class="text-center">' +
                '<button class="btn btn-sm btn-danger btn-del mb-1" type="button" title="Xóa" data-bs-toggle="modal" data-bs-target="#delModalConfirm" data-id="' + bookTrash.id + '" data-book-name="' + bookTrash.name + '" onclick="event.stopPropagation()"><i class="bi bi-trash"></i></button>' +
                '<form id="restoreForm" method="post"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>' +
                '<button class="btn btn-sm btn-warning btn-restore" type="button" title="Khôi phục" data-id="' + bookTrash.id + '" onclick="event.stopPropagation()"><i class="bi bi-recycle"></i></button></form>' +
                '</td>';
            tbody.appendChild(row);
        });
        $('.datatable').DataTable({
            lengthMenu: [
                [5, 10, 15, -1],
                [5, 10, 15, 'All']
            ],
            columnDefs: [
                {
                    targets: 2,
                    orderSequence: ['desc', 'asc']
                },
                {
                    targets: 3,
                    orderSequence: []
                },
            ],
            headerCallback: function (thead, data, start, end, display) {
                $(thead).find('th').eq(4).addClass('red');
            }
        });

        $('.btn-restore').click(function () {
            const id = $(this).attr('data-id');
            const form = document.getElementById("restoreForm")
            form.setAttribute('action', '/admin/restore-book/' + id);
            form.submit();
        });

        let currentId = null;
        document.querySelectorAll('.btn-del').forEach(button => button.addEventListener('click', function () {
            currentId = button.getAttribute('data-id');
            const productName = button.getAttribute('data-book-name');
            const modalBody = document.querySelector('.modal-body');
            modalBody.innerHTML = 'Bạn muốn xóa vĩnh viễn sách ' + productName + '?';
        }));

        document.getElementById('form-confirm-del').addEventListener('submit', function (event) {
            event.preventDefault();
            event.stopPropagation();
            this.setAttribute('action', '/admin/del-permanently-book/' + currentId);
            this.submit();
        })

    })
</script>
</body>

</html>