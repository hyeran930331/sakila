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
				카테고리 :
			<select id="category" name="category">
				<option value="">모두보기</option>
				<c:forEach var="cl" items="${categoryList}">
					<option value="${cl.name}" ${cl.name.equals(category) ? "selected=selected" : ""} >${cl.name}</option>					
				</c:forEach>
			</select> 

				가격 :
			<select id="price" name="price">
				<option value="">모두보기</option>
				<option value="0.99" ${price == 0.99 ? "selected=selected" : ""} >0.99</option>
				<option value="2.99" ${price == 2.99 ? "selected=selected" : ""} >2.99</option>
				<option value="4.99" ${price == 4.99 ? "selected=selected" : ""} >4.99</option>
			</select>

				등급 :  
	    	<select id="rating" name="rating" >
	    		<option value="">모두보기</option>
	    		<option value="G" ${rating == 'G' ? "selected=selected" : ""} >G</option>
	    		<option value="PG" ${rating == 'PG' ? "selected=selected" : ""} >PG</option>
				<option value="PG-13" ${rating == 'PG-12' ? "selected=selected" : ""} >PG-13</option>
				<option value="R" ${rating == 'R' ? "selected=selected" : ""} >R</option>	
	    		<option value="NC-17" ${rating == 'NC-17' ? "selected=selected" : ""} >NC-17</option>
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
				<th>filmId</th>
				<th>title</th>
				<th>category</th>
				<th>price</th>
				<th>rating</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="f" items="${filmList}">
				<tr>
					<td>${f.filmId}</td>
					<td> <a href="${pageContext.request.contextPath}/admin/getFilmOne?filmId=${f.filmId}"> ${f.title}</a></td>
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
             <li class="previous"><a href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${currentPage-1}&category=${category}&price=${price}&rating=${rating}&title=${title}&actor=${actor}">이전</a></li>
        </c:if>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=1">첫페이지로</a>
        <c:if test="${currentPage < lastPage}">
             <li class="next"><a href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${currentPage+1}&category=${category}&price=${price}&rating=${rating}&title=${title}&actor=${actor}">다음</a></li>
         </c:if>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${lastPage}">마지막 페이지로</a>
    </ul>
    <div>
    	<form action="/admin/addFilm" method="get">
       	 <button type="submit" class="btn btn-default">영화 입력</button>
        </form>
    </div>
</div>
</body>
</html>