<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>getStaffList</title>
<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

</head>
<body>
<div class="container">
    <h1>getStaffList</h1>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>SID</th>
                <th>ID</th>
                <th>name</th>
                <th>phone</th>
                <th>address (country,city,address)</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="s" items="${staffList}">
                <tr>
                	<td>${s.storeId}</td>
                	<td>${s.staffId}</td>
                    <td>${s.username}</td>
                    <td>${s.phone}</td>
                    <td>${s.country}, ${s.city}, ${s.address}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
   <!-- 검색어 입력창 -->
    <form action="admin/getStaffList" method="get">
        <label for="searchWord">검색어(이름) :</label> 
        <input name="searchWord" type="text">
        <button type="submit">검색</button>
    </form>

    <ul class="pager">
        <c:if test="${currentPage > 1}">
            <li class="previous"><a href="${pageContext.request.contextPath}/admin/getStaffList?currentPage=${currentPage-1}&searchWord=${searchWord}">이전</a></li>
        </c:if>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getStaffList?currentPage=1">첫페이지로</a>
        
        <c:if test="${currentPage < lastPage}">
            <li class="next"><a href="${pageContext.request.contextPath}/admin/getStaffList?currentPage=${currentPage+1}&searchWord=${searchWord}">다음</a></li>
        </c:if>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getStaffList?currentPage=${lastPage}">마지막 페이지로</a>
    </ul>
    <div>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/">직원 추가</a>
    </div>
</div>
</body>
</html>