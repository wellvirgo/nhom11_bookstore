<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <h1>Danh sách sản phẩm</h1>

  <!-- FORM tìm kiếm -->
  <form action="${pageContext.request.contextPath}/product/search" method="get">
    <input type="text" name="keyword" placeholder="Nhập tên sản phẩm..." value="${keyword}" />
    <button type="submit">Tìm kiếm</button>
  </form>
  
  <hr/>

  <c:if test="${not empty listSP}">
    <ul>
      <c:forEach var="p" items="${listSP}">
        <li>
          <a href="${pageContext.request.contextPath}/product/detail/${p.id}">
            ${p.name}
          </a>
           – Giá: ${p.price}
        </li>
      </c:forEach>
    </ul>
  </c:if>
  
  <c:if test="${empty listSP}">
    <p>Không tìm thấy sản phẩm nào.</p>
  </c:if>
</body>
</html>