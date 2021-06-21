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

<title>add inventory</title>
<script>
	$(document).ready(function(){
		$('#addForm').click(function(){
			if( $('#storeId').val() == ''){
				alret.()
			}
			else if ( $('#num').val == ''){
				
			}
			else { $('#addForm').submit)
			}
		});
	});
</script>
</head>
<body>
<div class="container text-center">
    <h1>Add inventory VIEW</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
    
     <form action="/admin/addInventory" name="addForm" id="addForm" method="post">
     <table class="table">
        <tr>
          <td >filmId :</td>
          <td>(category)   title :</td>
        </tr>
        
        <tr>
          <td>${filmList.filmId} <input type="text" hidden="hidden" name="filmId" value="${filmList.filmId}"></td>
          <td>(${filmList.category})   ${filmList.title}</td>          
        </tr>
  		
  		<c:forEach var="f" varStatus="status" items="${FilmInStockStore }">
        <tr>
          <td>가게 ${status.count} 재고:</td>
          <td>${f}</td>
        </tr>
        </c:forEach>
        
        <tr>
        	<td>가게 선택</td>
        	<td>
        		<select name="storeId" id="storeId">
        			<option value="">선택하기</option>
        			<option value="1">store1</option>
        			<option value="2">store2</option>
        		</select>
        	</td>
        </tr>
        
        <tr>
        	<td>수량 입력</td>
        	<td>
        		<input type="text" id="num" name="num">
        	</td>
        </tr>
    </table>
    <div>
    	<button id="btn" name="btn"> 제출 </button>
    </div>
    
    </form>
    
    <!-- 버튼들 -->
    <c:if test="${filmList.filmId != 1}">
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addInventory?filmId=${filmId-1}">이전필름 추가</a>
    </c:if>
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList">목록으로</a>
    <c:if test="${filmList.filmId != lastPage}">
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addInventory?filmId=${filmId+1}">다음필름 추가</a>
    </c:if>
	
</div>
</body>
</html>