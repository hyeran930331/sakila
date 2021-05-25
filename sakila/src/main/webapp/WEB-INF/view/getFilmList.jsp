<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="table">
		<thead>
		<tr>
			<th>film_id</th>
			<th>title</th>
			<th>length</th>
			<th>rental_rate</th>
			<th>rating</th>
			<th>special_features</th>
		</tr>
		</thead>
		
		<c:forEach var="f" items="${filmList}">
		<tr>
			<th>${f.filmId}</th>
			<th>
				<a href="${pageContext.request.contextPath}/admin/getFilmOne?filmId=${f.filmId}&storeId=${session.storeId}">
				${f.title}
			</a>
			</th>
			<th>${f.length}</th>
			<th>${f.rentalRate}</th>
			<th>${f.rating}</th>
			<th>${f.specialFeatures}</th>
		</tr>
		</c:forEach>
		
	</table>
	
	<!-- 검색어 입력창 -->
    <form action="/getFilmList" method="get">
		category:
		<select name="serarch">
			<c:forEach var="category" items="${categoryList }">
				<c:if test="${category == category}">
					<option value="${category}">${category}</option>
				</c:if>
				<c:if test="${category != null}">
					<option value="${category}">${category}</option>
				</c:if>
			</c:forEach>
		</select>    
    	
        <label for="searchWord">검색어(영화이름) :</label> 
        <input name="searchWord" type="text">
        <button type="submit">검색</button>
    </form>

    <ul class="pager">
        <c:if test="${currentPage > 1}">
            <li class="previous"><a href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${currentPage-1}&searchWord=${searchWord}">이전</a></li>
        </c:if>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=1">첫페이지로</a>
        
        <c:if test="${currentPage < lastPage}">
            <li class="next"><a href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${currentPage+1}&searchWord=${searchWord}">다음</a></li>
        </c:if>
        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${lastPage}">마지막 페이지로</a>
    </ul>

</body>
</html>