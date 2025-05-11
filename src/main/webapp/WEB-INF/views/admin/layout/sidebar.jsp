<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
            <a class="nav-link" href="/admin/das">
                <i class="bi bi-grid"></i>
                <span>Dashboard</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#books-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-book"></i><span>Quản lý sách</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="books-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                <li>
                    <a href="/admin/list-books">
                        <i class="bi bi-circle"></i><span>Kho sách</span>
                    </a>
                </li>
                <li>
                    <a href="/admin/add-book">
                        <i class="bi bi-circle"></i><span>Thêm mới sách</span>
                    </a>
                </li>
            </ul>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#orders-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-cart"></i><span>Quản lý đơn hàng</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="orders-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                <li>
                    <a href="/admin/list-orders">
                        <i class="bi bi-circle"></i><span>Danh sách đơn hàng</span>
                    </a>
                </li>
            </ul>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#users-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-people"></i><span>Quản lý người dùng</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="users-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                <li>
                    <a href="users-list.html">
                        <i class="bi bi-circle"></i><span>Danh sách người dùng</span>
                    </a>
                </li>
            </ul>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" href="settings.html">
                <i class="bi bi-gear"></i>
                <span>Cài đặt</span>
            </a>
        </li>

    </ul>

</aside>