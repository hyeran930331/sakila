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
<title>get CustomerList</title>
<script>
$(document).ready(function(){
	$('#btn').click(function() { 
    	console.log('btn 클릭');
        $('#getForm').submit();
    });

});
</script>
</head>
<body>
<div class="container">
    <h1>getCustomerList</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
	<!-- 검색어 입력창 -->
    <form action="/admin/getCustomerList" name="getForm" id="getForm" method="get">
		<div>
		가게별
			<select name="storeId" id="storeId">
				<option value="">모두보기</option>
				<option value="1">store 1 </option>
				<option value="2">store 2 </option>
			</select>

        이름 :
	        <input name="searchWord" id="searchWord" type="text">
	        
	        <button name="btn" id="btn" type="button">검색</button>
 		</div>

	<table class="table">
		<thead>
			<tr>
				<th>storeId</th>
				<th>customerId</th>
				<th>name</th>
				<th>email</th>
				<th>blackList</th>
				<th>
				2005.04.25-05.25
				<br>
				VIP</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="c" items="${customerList}">
				<tr>
					<td>${c.storeId}</td>
					<td>${c.customerId}</td>
					<td><a href="${pageContext.request.contextPath}/admin/getCustomerOne?customerId=${c.customerId}">${c.name}</a></td>
					<td>${c.email}</td>
					<td>${c.blackList}</td>
					<td>${c.vipList}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
   </form>
   
 <!-- 페이징 검색어 적용-->
    <ul class="pager">
         <c:if test="${currentPage > 1}">
             <li class="previous"><a href="${pageContext.request.contextPath}/admin/getCustomerList?currentPage=${currentPage-1}&serchWord=${searchWord}&storeId=${storeId}">이전</a></li>
        </c:if>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList?currentPage=1&serchWord=${searchWord}&storeId=${storeId}">첫페이지로</a>

        <c:if test="${currentPage < lastPage}">
             <li class="next"><a href="${pageContext.request.contextPath}/admin/getCustomerList?currentPage=${currentPage+1}&serchWord=${searchWord}&storeId=${storeId}">다음</a></li>
         </c:if>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList?currentPage=${lastPage+1}&serchWord=${searchWord}&storeId=${storeId}">마지막 페이지로</a>
    </ul>
    <div>
    
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addCustomer">고객 입력</a>
    </div>
</div>
</body>
</html>