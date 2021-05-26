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

<title>Film One VIEW(spring mvc 방식)</title>
</head>
<body>
<div class="container text-center">
    <h1>Film One VIEW</h1>
     <table class="table">
        <tr>
          <td width="300">FID :</td>
          <td>${filmList.FID}</td>
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
        
        <c:forEach var="f" varStatus="status" items="${FilmInStockStore }">
        <tr>
          <td>가게 ${status.count} 재고:</td>
          <td>${f}</td>
          
        </tr>
        </c:forEach>
        
        
        
        <tr>
          <td>설명</td>
          <td>${filmList.description}</td>
        </tr>
        
        <tr>
          <td>배우</td>
          <td>
          	${filmList.actors } <br>
          	<!-- 배우마다 한줄띄기 하고싶었습니다. 와 이게 한번에 되다니...-->
			<c:forTokens var="temp" items="${filmList.actors } " delims=",">
				<a href="${pageContext.request.contextPath}/admin/getActorOne?Actor=${temp}"> ${temp }</a><br>
			</c:forTokens>
          </td>
        </tr>
        
      
    </table>
    
    <!-- 버튼들 -->
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