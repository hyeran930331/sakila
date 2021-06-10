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
<title>add Rental</title>
<script>

</script>
</head>
<body>
	<div class="container text-center">
	<h1>add Rental</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
	
	<form name="addForm" action="" method="post">
	<table class="table">
		<tr><td colspan="2">　</td></tr>
		<tr><th colspan="2">　</th></tr>
		<tr><th colspan="2">　</th></tr>
		<tr bgcolor="yellow">
			<th>storeId : name(customerId)</th>
			<td width="900">가게${storeId} : ${name}(${customerId}) </td>
		</tr>
		
		<tr><td colspan="2"> <button class="btn btn-default" type="button" name="btn"> 추가</button></td></tr>
		
		<tr>
			<td>직원</td>
			<td><input type="text" name="staff">스태프 리스트 출력</td>
		</tr>
		
		<tr>
			<td>인벤토리(바코드)</td>
			<td><input type="text" name="staff">바코드 리스트 선택</td>
		</tr>
		
		<tr>
			<td>금액</td>
			<td><input type="text" name="amount">총금액</td>
		</tr>
		
		<tr>
			<td>대여기간</td>
			<td><input type="text" name="amount">기간</td>
		</tr>
		
	</table>
	</form>
	</div>
</body>
</html>