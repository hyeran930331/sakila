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
<title>get filmList</title>
</head>
<body>
<div class="container">
    <h1>getFilmList</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
	<!-- 검색어 입력창 -->
    <form action="/admin/getFilmList" method="get">
			<div>
			카테고리
				<select id="category" name="category">
					<option value="">모두보기</option>
					<c:forEach var="c" items="${categoryList}">
					
						<c:if test = "${c.equals(category)}" >
							<option selected="selected" value="${c.categoryId}">${c.name}</option>
						</c:if>
						
						<c:if test="${!c.equals(category)}">
							<option value="${c.categoryId}">${c.name}</option>
						</c:if>
						
					</c:forEach>
				</select>

				가격 :
				<select id="price" name="price">
					<option value="">모두보기</option>
					<c:if test="${price == 0.99}">
						<option value="0.99" selected="selected">0.99</option>
					</c:if>
					<c:if test="${price != 0.99}">
						<option value="0.99">0.99</option>
					</c:if>

					<c:if test="${price == 2.99}">
						<option value="2.99" selected="selected">2.99</option>
					</c:if>
					<c:if test="${price != 2.99}">
						<option value="2.99">2.99</option>
					</c:if>

					<c:if test="${price == 4.99}">
						<option value="4.99" selected="selected">4.99</option>
					</c:if>
					<c:if test="${price != 4.99}">
						<option value="4.99">4.99</option>
					</c:if>
				</select>

				등급 :
	    	<select id="rating" name="rating" >
	    		<option value="">모두보기</option>
	    		
	    		<c:if test="${rating == 'G'}">
						<option value="G" selected="selected">G</option>
					</c:if>
					<c:if test="${rating != 'G'}">
						<option value="G">G</option>
					</c:if>
					
				<c:if test="${rating == 'PG'}">
						<option value="PG" selected="selected">PG</option>
					</c:if>
					<c:if test="${rating != 'PG'}">
						<option value="PG">PG-13</option>
					</c:if>	
					
	    		<c:if test="${rating == 'PG-13'}">
						<option value="PG-13" selected="selected">PG-13</option>
					</c:if>
					<c:if test="${rating != 'PG-13'}">
						<option value="PG-13">PG-13</option>
					</c:if>
					
				<c:if test="${rating == 'R'}">
						<option value="R" selected="selected">R</option>
					</c:if>
					<c:if test="${rating != 'R'}">
						<option value="R">R</option>
					</c:if>	
					
				<c:if test="${rating == 'NC-17'}">
						<option value="NC-17" selected="selected">NC-17</option>
					</c:if>
					<c:if test="${rating != 'NC-17'}">
						<option value="NC-17">NC-17</option>
					</c:if>
			</select>							    
		    </div>
    	
        영화이름 :
	        <input name="title" type="text">
	    배우 :   
	        <input name="actor" type="text">
	        <button type="submit">검색</button>
 


	<table class="table">
		<thead>
			<tr>
				<th>FID</th>
				<th>title</th>
				<th>category</th>
				<th>price</th>
				<th>rating</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="f" items="${filmList}">
				<tr>
					<td>${f.FID}</td>
					<td> <a href="${pageContext.request.contextPath}/admin/getFilmOne?FID=${f.FID}"> ${f.title}</a></td>
					<td>${f.category}</td>
					<td>${f.price}</td>
					<td>${f.rating}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
   </form>
   
 <!-- 페이징 검색어 적용전-->
    <ul class="pager">
         <c:if test="${currentPage > 1}">
             <li class="previous"><a href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${currentPage-1}">이전</a></li>
        </c:if>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=1">첫페이지로</a>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=(int)(Math.ceil((double)currentPage/ rowPerPage))}">목록 페이지로</a>
        <!-- ex 32페이지다 32/10 = 3.xx -> (int)3.xx => 3 --> 
        <c:if test="${currentPage < lastPage}">
             <li class="next"><a href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${currentPage+1}">다음</a></li>
         </c:if>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${lastPage}">마지막 페이지로</a>
    </ul>
    <div>
    
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addFilm">영화 입력</a>
    </div>
</div>
</body>
</html>