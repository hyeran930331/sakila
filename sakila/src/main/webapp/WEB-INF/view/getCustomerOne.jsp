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

<title>Customer One VIEW(spring mvc 방식)</title>
</head>
<body>
<div class="container text-center">
    <h1>Customer One VIEW</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
     <form id="addForm" action="" method="post">
     <table class="table">
     		<c:forEach var="co" items="${customerOne}">
     		<c:set var="customerId" value="${co.customerId}"/>
			<tr>
				<th width="300">storeId(customerId) name</th>
				<td>${co.storeId} (${co.customerId}) ${co.name}</td>
			</tr>
			<tr>
				<th>phone (email)</th>
				<td>${co.phone} (${co.email})</td>
			</tr>
			<tr>
				<th>full address (zip code)</th>
				<td>${co.country}, ${co.city}, ${co.address} ( ${co.zipCode} )</td>
			</tr>	
			<tr>
				<th>총 구매 금액</th>
				<td>${co.amount}</td>
			</tr>
			</c:forEach>
			<tr>
				<th>대여목록</th>
				<td class="container">
					<table class="table table-striped">
						<thead class="center">
						<tr>
						<th>rentalId</th>
						<th>inventoryId</th>
						<th>title</th>
						<th>rentalDate</th>
						<th>returnDate</th>
						<th>연체일</th>
						</tr>
						</thead>
						
						<tbody>
						
						<c:forEach var="rl" items="${rentalList}">
							<c:set var="count" value="0"/>
							<tr>
							<td>${rl.rentalId}</td>
							<td>${rl.inventoryId}</td>
							<td>${rl.title }</td>
							<td>${rl.rentalDate}</td>
							<td>${rl.returnDate}</td>
							<td>
								<c:if test="${rl.overdueDate>0}">
									${rl.overdueDate} 일 연제중
								</c:if>
								<c:if test="${rl.black > 0}">
									<c:set var="count" value="${count+1}"/>
									${count}번째 : 연체반납 ( ${rl.black}일)
								</c:if>
							</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</td>
			</tr>
	</table>
	<div>
		<button type="button" id="btn">대여하기</button>
	</div>
	</form>
    
    
    <!-- 버튼들 -->
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerOne?customerId="${customerId-1}>이전으로</a>
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList">목록으로</a>
	
</div>
</body>
</html>