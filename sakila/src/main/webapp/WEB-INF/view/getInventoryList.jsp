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
	console.log('$(document).ready');	
	$('#btnSearch').click(function(){
		console.log('$(#btnSearch).click');	
		if ('#title'.val !='' || 'inventoryId'.val !=''){
			$('#searchForm').submit
		}
	});
	
	$('#btnReturn').click(function(){
		console.log('$(#btnReturn).click');	
		console.log('#delFilmBtn click!');	
		if ( this.host !== window.location.host ) {
            if ( window.confirm( '연체금을 받았나요') ) {
                // They clicked Yes
                console.log('감사합니다.');
            }
            else {
                // They clicked no
                console.log('받아야 반납이 가능합니다.');
                return false
            }
		}
	});
});
</script>
<title>get InventoryList</title>
</head>
<body>
<div class="container">
    <h1>getInventoryList</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
	<!-- 검색어 입력창 -->
    <form action="/admin/getInventoryList" name="searchForm" method="get">
		<div>
        영화이름 :
	        <input name="title" type="text">
	    inventory_id :   
	        <input name="inventoryId" type="text">
	        <button name="btnSearch" type="submit">검색</button>
 		</div>
   </form>
	
	
	<table class="table">
		<thead>
			<tr>
				<th>inventoryId</th>
				<th>title</th>
				<th>storeId</th>
				<th>연체일</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" items="${inventoryList}">
				<font ${i.overdueDate != '' ? 'color="red"' : ''} > <!-- 왜 안될까욥 -->
				
					<tr id="line" ${i.overdueDate != '' ? 'bgcolor="red"' : ''}>
						<td>${i.inventoryId} </td>
						<td> <a href="${pageContext.request.contextPath}/admin/getInventoryOne?inventoryId=${i.inventoryId}&title=${i.title}"> ${i.title}</a></td>
						<td>${i.storeId}</td>
						<td>${i.overdueDate}  </td>
						
						<td>
						<c:if test="${i.overdueDate !=''}">
							<a name="btnReturn" class="btn btn-default" href="${pageContext.request.contextPath}/admin/modifyRentalPayment?inventoryId=${i.inventoryId}&overdueDate=${i.overdueDate}" >${i.customerName} 회원 반납</a>
						</c:if>
						</td>
					</tr>
				</font>
			</c:forEach>
		</tbody>
	</table>
  
   
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
</div>
</body>
</html>