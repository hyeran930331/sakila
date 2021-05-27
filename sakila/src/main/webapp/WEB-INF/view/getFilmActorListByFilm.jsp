<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>


<script>
	$(document).ready(function() {
	    $('#btn').click(function() { 
	    	console.log('btn 클릭');
	        $('#modifyFilmActor').submit();
	    });
	});
</script> 
 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>getFilmActorListByFilm(spring mvc 방식)</title>
</head>
<body>
<div class="container text-center">
    <h1>영화 출연진 수정</h1> <jsp:include page="/WEB-INF/view/nav.jsp"/>
    
    <form action="/admin/modifyFilmActor" id="modifyFilmActor">
	<table class="table">
        <tr>
          <td>${filmId}번 film 출연배우 수정 	<button id="btn" name="btn"> 제출</button>
          <input hidden="hidden" id="filmId" value="${filmId}">
          </td>
        </tr> 
         
        <tr>
          <td>
          
          	<table class="text-left table-striped">
          		<tr>
				<c:forEach var="c" items="${castingListByFilm}" varStatus="status">
					<c:if test="${((status.count) %5)==1}">
						<tr>
					</c:if>
					
						<td>
							<c:if test="${c.cast !=null}">
								<input name="cast[${status.index}]" type="checkbox" checked="checked" value="${c.actorId}">
							</c:if>
							
							<c:if test="${c.cast ==null}">
								<input name="cast[${status.index}]" type="checkbox" value="${c.actorId}">
							</c:if>
							${status.count}. ${c.name}
						</td>
						
					<c:if test="${((status.count) %5)==0}">
						<tr>
					</c:if>
					
				</c:forEach>
				</tr>
			</table>
          </td>
        </tr>
    </table>
    </form>
    
<!--
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/modifyFilm?FilmId=${filmList.FID}">수정(구현전404)</a>
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/removeFilm?filmList=${filmList.FilmId}">삭제(구현전404))</a>
    <br>
    <c:if test="${((filmList.FilmId)-1)>0}">
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmOne?FilmId=${(filmList.FilmId)-1}">이전글</a>
    </c:if>
-->
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList">목록으로</a>
 <!-- 
    <c:if test="${((filmList.FilmId)+1)<FilmTotal}">
    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmOne?FilmId=${(filmList.FilmId)+1}">다음글</a>
    </c:if>
  -->
</div>
</body>
</html>