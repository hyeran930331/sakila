<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<title>Film One VIEW(spring mvc 방식)</title>
<script>
	$(document).ready(function(){
		$('#btn').click(function(){
			console.log('addButton 클릭');
			$('#addForm').submit();
		});
	});
</script>
</head>
<body>
<div class="container text-center">
    <h1>Film One VIEW</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
    
    <form action="${pageContext.request.contextPath}/admin/addInventory" id="addForm" name="addForm" method="get">
     <table class="table">
        <tr>
          <td >filmId :</td>
          <td>
          <!-- paging -->
		    <ul class="pager">	
		    <c:if test="${filmList.filmId != 1}">
		   		<li class="previous"><a href="${pageContext.request.contextPath}/admin/getFilmOne?filmId=${filmList.filmId-1}">이전으로</a></li>
		    </c:if>
          	${filmList.filmId}
          	 <c:if test="${filmList.filmId != lastPage}">
		    	<li class="next"><a href="${pageContext.request.contextPath}/admin/getFilmOne?filmId=${filmList.filmId+1}">다음으로</a></li>
		    </c:if>
		    </ul>
          	 <input type="text" hidden="hidden" value="${filmList.filmId}" name="filmId"></td>
        </tr>
        
        <tr>
          <td> title :</td>
          <td>${filmList.title}</td>
        </tr>
        
        <tr>
          <td> rating :</td>
          <td>${filmList.rating}</td>
        </tr>
        
        <tr>
          <td> length :</td>
          <td>${filmList.length}</td>
        </tr>
        
         <tr>
          <td> price :</td>
          <td>${filmList.price}</td>
        </tr>
        
        <tr>
          <td> category :</td>
          <td>${filmList.category}</td>
        </tr>
        
        <tr>
        <td>　</td>
        <td>　</td>
        </tr>
        
        <c:forEach var="f" varStatus="status" items="${FilmInStockStore }">
        <tr>
          <td>가게 ${status.count} 재고:</td>
          <td>${f}</td>
          
        </tr>
        </c:forEach>
        <tr>
        	<td>재고추가</td>
        	<td><button type="button" id="btn" name="btn" class="btn btn-default">재고 추가</button></td>
        </tr>
        
        
        <tr>
          <td>설명</td>
          <td>${filmList.description}</td>
        </tr>
        
        <tr>
          <td>배우
          <br>
          <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/modifyFilmActor?filmId=${filmList.filmId}">배우수정하기</a> 
          </td>
          
          <td class="text-left">
          	<!-- 배우마다 한줄띄기 하고싶었습니다. 와 이게 한번에 되다니...-->
			<c:forTokens var="temp0" items="${filmList.actors } " delims="," varStatus="status">
				<c:set var="temp1" value=""/>
				<c:forTokens var="temp2" items="${temp0} " delims=" " varStatus="g">
					<c:if test="${g.count==1}">
						<c:set var="temp1" value="firstName=${temp2}"/>
					</c:if>
					<c:if test="${g.count==2}">
						<c:set var="temp1" value="${temp1}&lastName=${temp2}"/>
					</c:if>
				</c:forTokens>
				<a href="${pageContext.request.contextPath}/admin/getActorOne?${temp1}">${status.count} ${temp0}</a><br>
			</c:forTokens>
          </td>
        </tr>
    </table>
    <div>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/modifyFilm?filmId=${filmList.filmId}">영화수정</a>
    </div>
    </form>
    
	<div>
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList">목록으로</a>
	</div>
	
</div>
</body>
</html>