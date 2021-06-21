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
	$(document).ready(function(){
		console.log('레디');
		
		$(document).on('keyup', '#inventoryId', function() {
			console.log('엔터');

			$.ajax({
				type:'get',
				url:'/inventory',
				data : { inventoryId : $('#inventoryId').val() },
				success: function(jsonData){
					$('#title').empty();
					$('#amount').empty();
					$('#duration').empty();
					console.log('비우기완료');
					$(jsonData).each(function(index, item){
						$('#title').text(item.title);
						$('#amount').append('<input class="form-control" type="text" name="amount" value="'+item.amount+'"/>');
						$('#duration').text(item.duration);
						console.log('받기완료');
					});//jsonData
				} //success
			}); //ajax

		});//inventoryId

		$('#btn').click(function(){
			console.log('btn click');	
			 $('#addForm').submit();
		});//click
		
	});//document
</script>
</head>
<body>
	<div class="container text-center">
	<h1>add Rental</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
	
	<form name="addForm" action="${pageContext.request.contextPath}/admin/addRental" method="post">
	<table class="table">
		<tr><td colspan="2">　</td></tr>
		<tr><th colspan="2">　</th></tr>
		<tr><th colspan="2">　</th></tr>
		<tr bgcolor="yellow">
			<th>storeId : name(customerId)</th>
			<td width="900">가게${storeId} : ${name}(${customerId}) </td>
		</tr>
		
		<tr><td></td>
			<td><button class="btn btn-default" type="button" name="btn"> 추가</button></td></tr>
		
		<tr>
			<td>직원</td>
			<td>
				<select class="form-control" name="staffId" id="staffId">
					<option value=""> 선택하세요 </option>
					
					<c:forEach var="sl" items="${staffList}">
					<option value="${sl.staffId}">${sl.username }</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		
		<tr>
			<td>인벤토리(바코드)</td>
			<td colspan="2">
			<input class="form-control" type="text" id="inventoryId" placeholder="바코드 입력후 엔터">
			<span id="title"> </span>
			</td>
		</tr>
		
		<tr>
			<td>금액 (달러)</td>
			<td><span id="amount"></span></td>
		</tr>
		
		<tr>
			<td>대여기간 (일)</td>
			<td><span id="duration"></span></td>
		</tr>
		
		<tr>
			<td></td>
			<td> <input type="reset"/>초기화</td>
		</tr>
	</table>
	</form>
	
	</div>
</body>
</html>