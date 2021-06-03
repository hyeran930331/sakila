<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
    integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
    crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
    integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
    crossorigin="anonymous">
 
<!-- jquery를 사용하기위한 CDN주소 -->
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 
<!-- bootstrap javascript소스를 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified JavaScript -->
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
    integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
    crossorigin="anonymous"></script>
 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script>
$(document).ready(function(){
	console.log($('#category').val());
});
</script>
<title>get InventoryList</title>
</head>
<body>
<div class="container">
    <h1>getInventoryList</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
	<!-- 검색어 입력창 -->
    <form action="/admin/getInventoryList" method="get">
			<div>
        영화이름 :
	        <input name="title" type="text">
	    inventory_id :   
	        <input name="inventoryId" type="text">
	        <button type="submit">검색</button>
 			</div>


	<table class="table">
		<thead>
			<tr>
				<th>inventoryId</th>
				<th>title</th>
				<th>storeId</th>
				<th>rentalDate</th>
				<th>returnDate</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" items="${inventoryList}">
				<tr>
					<td>${i.inventoryId}</td>
					<td> <a href="${pageContext.request.contextPath}/admin/getInventoryOne?rentalId=${i.rentalId}"> ${i.title}</a></td>
					<td>${i.storeId}</td>
					<td>${i.rentalDate}</td>
					<td>${i.returnDate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
   </form>
   
 <!-- 페이징 검색어 적용전-->
    <ul class="pager">
         <c:if test="${currentPage > 1}">
             <li class="previous"><a href="${pageContext.request.contextPath}/admin/getInventoryList?currentPage=${currentPage-1}">이전</a></li>
        </c:if>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getInventoryList?currentPage=1">첫페이지로</a>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getInventoryList?currentPage=(int)(Math.ceil((double)currentPage/ rowPerPage))}">목록 페이지로</a>
        <!-- ex 32페이지다 32/10 = 3.xx -> (int)3.xx => 3 --> 
        <c:if test="${currentPage < lastPage}">
             <li class="next"><a href="${pageContext.request.contextPath}/admin/getInventoryList?currentPage=${currentPage+1}">다음</a></li>
         </c:if>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getInventoryList?currentPage=${lastPage}">마지막 페이지로</a>
    </ul>
    <div>
    
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addInventory">재고 입력</a>
    </div>
</div>
</body>
</html>